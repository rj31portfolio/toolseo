<?php
final class KeywordAnalysis {
 public static function keywords(int $wid): array {
  return rows('SELECT k.*,r.position,r.url AS ranking_url,r.date AS ranking_date,r.source AS ranking_source,(SELECT position FROM keyword_rankings p WHERE p.keyword_id=k.id AND p.date<r.date ORDER BY p.date DESC LIMIT 1) AS previous_position,(SELECT date FROM keyword_rankings p WHERE p.keyword_id=k.id AND p.date<r.date ORDER BY p.date DESC LIMIT 1) AS previous_date FROM keywords k LEFT JOIN keyword_rankings r ON r.keyword_id=k.id AND r.date=(SELECT MAX(date) FROM keyword_rankings x WHERE x.keyword_id=k.id) WHERE k.website_id=? ORDER BY k.keyword,k.id',[$wid]);
 }
 public static function summarize(array $keywords): array {
  $s=['total'=>count($keywords),'ranked'=>0,'unchecked'=>0,'missing'=>0,'top3'=>0,'top10'=>0,'top20'=>0,'improved'=>0,'declined'=>0,'stable'=>0,'average'=>null,'volume_available'=>0];$sum=0;
  foreach($keywords as $k){$p=$k['position'];if($p===null){$s[empty($k['ranking_date'])?'unchecked':'missing']++;}else{$s['ranked']++;$sum+=(int)$p;if($p<=3)$s['top3']++;if($p<=10)$s['top10']++;if($p>=11&&$p<=20)$s['top20']++;}
   if($p!==null&&($k['previous_position']??null)!==null)$s[$p<$k['previous_position']?'improved':($p>$k['previous_position']?'declined':'stable')]++;
   if(($k['search_volume']??null)!==null)$s['volume_available']++;
  }
  if($s['ranked'])$s['average']=round($sum/$s['ranked'],1);return $s;
 }
 public static function advice(array $k): string {
  if(empty($k['ranking_date']))return 'Run a ranking check to establish a baseline.';
  if($k['position']===null)return 'Check indexing and target URL, then improve relevance to this search.';
  if(($k['previous_position']??null)!==null&&$k['position']>$k['previous_position'])return 'Ranking declined: review recent page changes and competing search results.';
  if($k['position']<=3)return 'Protect this result: keep content accurate and monitor changes.';
  if($k['position']<=10)return 'Improve title relevance and strengthen internal links to the ranking page.';
  if($k['position']<=20)return 'Near page one: improve search-intent coverage and supporting internal links.';
  return 'Review leading pages and expand useful, original coverage of this topic.';
 }
 public static function research(array $w,string $seed): array {
  $cached=Serp::saved((int)$w['id'],'keyword_research');$key=hash('sha256',json_encode([$seed,$w['country'],$w['language']]));
  if(($cached['key']??'')===$key&&($cached['date']??'')===date('Y-m-d'))return $cached;
  $ideas=[];$organic=[];$source='HasData Google SERP';$corrected='';
  if(cfg('KEYWORD_ENDPOINT')&&cfg('KEYWORD_API_KEY')){
   $source='Keyword provider';
   foreach((new GatewayProvider())->research($seed,$w['country'],$w['language']) as $r){
    if(!is_string($r['keyword']??null))throw new RuntimeException('Keyword provider returned an invalid keyword.');
    foreach(['search_volume','difficulty','cpc'] as $metric)if(isset($r[$metric])&&(!is_numeric($r[$metric])||$r[$metric]<0||($metric==='difficulty'&&$r[$metric]>100)))throw new RuntimeException('Keyword provider returned an invalid metric.');
    $ideas[]=['keyword'=>mb_substr($r['keyword'],0,190),'type'=>'Provider suggestion','search_volume'=>$r['search_volume']??null,'difficulty'=>$r['difficulty']??null,'cpc'=>$r['cpc']??null];
   }
  }else{
   $data=Serp::search($seed,$w['country'],$w['language']);$organic=Serp::organic($data);$corrected=mb_substr((string)($data['searchInformation']['showingResultsFor']??''),0,190);
   $ideas[]=['keyword'=>$seed,'type'=>'Seed keyword'];
   foreach($data['relatedSearches']??[] as $r){$term=is_array($r)?($r['query']??''):'';if(is_string($term)&&trim($term)!=='')$ideas[]=['keyword'=>mb_substr($term,0,190),'type'=>'Related Google search'];}
   foreach($data['relatedQuestions']??[] as $r){$term=is_array($r)?($r['question']??''):'';if(is_string($term)&&trim($term)!=='')$ideas[]=['keyword'=>mb_substr($term,0,190),'type'=>'People also ask'];}
  }
  $unique=[];foreach($ideas as $idea)$unique[mb_strtolower($idea['keyword'])]=$idea;
  $result=['key'=>$key,'seed'=>$seed,'date'=>date('Y-m-d'),'checked_at'=>date('Y-m-d H:i:s'),'country'=>$w['country'],'language'=>$w['language'],'source'=>$source,'corrected'=>$corrected,'ideas'=>array_slice(array_values($unique),0,40),'organic'=>$organic];
  Serp::save((int)$w['id'],'keyword_research',$result);return $result;
 }
}
