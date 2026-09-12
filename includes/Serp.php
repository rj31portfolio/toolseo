<?php
final class Serp {
 public static function available(): bool {return Ranking::source()==='hasdata_top100'&&(bool)cfg('RANKING_API_KEY');}
 public static function search(string $seed,string $country,string $language): array {
  if(!self::available())throw new RuntimeException('Connect HasData in Administration > Settings to search Google.');
  $params=HasDataRankProvider::parameters(['keyword'=>$seed,'country'=>$country,'language'=>$language,'device'=>'desktop','search_engine'=>'google']);
  try{$r=SafeHttp::request('https://api.hasdata.com/scrape/google/serp?'.http_build_query($params),'GET',['Accept: application/json','x-api-key: '.cfg('RANKING_API_KEY')],null,0,null,90);}catch(Throwable){throw new RuntimeException('Google research could not reach HasData. Please retry shortly.');}
  if($r['status']!==200)throw new RuntimeException(match($r['status']){401,403=>'HasData rejected the API key. Check your account configuration.',402=>'HasData credits are exhausted. Refill your account to continue.',429=>'HasData request limit reached. Please retry later.',default=>'HasData could not complete the search (HTTP '.$r['status'].').'});
  try{$data=json_decode($r['body'],true,64,JSON_THROW_ON_ERROR);}catch(Throwable){throw new RuntimeException('HasData returned unreadable search data.');}
  if(!is_array($data)||($data['requestMetadata']['status']??'ok')!=='ok'||isset($data['error'])||!is_array($data['organicResults']??null))throw new RuntimeException('HasData did not return a valid search result.');
  return $data;
 }
 public static function save(int $wid,string $key,array $data): void {
  $json=json_encode($data,JSON_THROW_ON_ERROR|JSON_UNESCAPED_UNICODE);
  if(strlen($json)>60000)throw new RuntimeException('Search result is too large to save.');
  query('INSERT INTO website_settings(website_id,name,value) VALUES (?,?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)',[$wid,$key,$json]);
 }
 public static function saved(int $wid,string $key): array {return json_decode(value('SELECT value FROM website_settings WHERE website_id=? AND name=?',[$wid,$key])?:'[]',true)?:[];}
 public static function organic(array $data): array {
  $results=[];
  foreach(array_slice($data['organicResults']??[],0,10) as $r){
   if(!is_array($r)||!is_string($r['link']??null))continue;
   try{$url=SafeHttp::normalize($r['link']);}catch(Throwable){continue;}
   $results[]=['position'=>(int)($r['position']??count($results)+1),'title'=>mb_substr((string)($r['title']??''),0,300),'url'=>$url,'snippet'=>mb_substr((string)($r['snippet']??''),0,700)];
  }
  return $results;
 }
}
