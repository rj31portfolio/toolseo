<?php
final class Ranking {
 public static function source(): string {return rtrim((string)cfg('RANKING_ENDPOINT'),'/')==='https://api.hasdata.com/scrape/google/serp'?'hasdata_top100':'api';}
 public static function label(?int $position,?string $source): string {
  if($position!==null)return '#'.$position;
  return match($source){null=> 'Not checked','hasdata_top100'=>'Not found (up to 100)','api'=>self::source()==='hasdata_top100'?'Not found (old check)':'Not found',default=>'No position supplied'};
 }
 public static function check(array $keyword): array {
  $lock='seo_rank_'.(int)$keyword['id'];
  if(!value('SELECT GET_LOCK(?,0)',[$lock]))throw new RuntimeException('This keyword is already being checked. Please wait a moment.');
  try{
   $source=self::source();
   $saved=row("SELECT * FROM keyword_rankings WHERE keyword_id=? AND date=CURDATE() AND source=?",[$keyword['id'],$source]);
   if($saved)return $saved;
   $records=(new ExternalRankProvider())->positions([$keyword]);
   if(count($records)!==1)throw new RuntimeException('The provider did not return one ranking for this keyword.');
   $r=$records[0];
   if((int)($r['keyword_id']??0)!==(int)$keyword['id']||!array_key_exists('position',$r)||($r['position']!==null&&(!is_int($r['position'])||$r['position']<1||$r['position']>1000)))throw new RuntimeException('Invalid ranking record.');
   $url=empty($r['url'])?'':SafeHttp::normalize($r['url']);
   query("INSERT INTO keyword_rankings(keyword_id,date,position,url,source) VALUES (?,CURDATE(),?,?,?) ON DUPLICATE KEY UPDATE position=VALUES(position),url=VALUES(url),source=VALUES(source)",[$keyword['id'],$r['position'],$url,$source]);
   return $r;
  }finally{value('SELECT RELEASE_LOCK(?)',[$lock]);}
 }
}
