<?php
final class HasDataRankProvider implements RankingProviderInterface {
 private ?Closure $transport;
 public function __construct(?callable $transport=null){$this->transport=$transport===null?null:Closure::fromCallable($transport);}
 public static function country(string $country): string {
  $country=strtolower(trim($country));
  $names=['india'=>'in','united states'=>'us','usa'=>'us','united kingdom'=>'gb','uk'=>'gb','canada'=>'ca','australia'=>'au','germany'=>'de','france'=>'fr','singapore'=>'sg','united arab emirates'=>'ae','uae'=>'ae','pakistan'=>'pk','bangladesh'=>'bd','nepal'=>'np','sri lanka'=>'lk','new zealand'=>'nz','south africa'=>'za','ireland'=>'ie','netherlands'=>'nl','spain'=>'es','italy'=>'it','brazil'=>'br','japan'=>'jp'];
  if(isset($names[$country]))return $names[$country];
  if(preg_match('/^[a-z]{2}$/',$country))return $country;
  throw new RuntimeException('Use a two-letter country code (for example IN, US or GB) in the keyword settings.');
 }
 public static function parameters(array $keyword): array {
  if(strtolower($keyword['search_engine']??'google')!=='google')throw new RuntimeException('HasData ranking checks support Google. Change this keyword\'s search engine to google.');
  $language=strtolower(trim($keyword['language']??'en'));
  if(!preg_match('/^[a-z]{2,3}(?:-[a-z]{2,4})?$/',$language))throw new RuntimeException('Use a language code such as en or hi in the keyword settings.');
  $device=$keyword['device']??'desktop';
  if(!in_array($device,['desktop','mobile'],true))throw new RuntimeException('Select desktop or mobile in the keyword settings.');
  return ['q'=>$keyword['keyword'],'gl'=>self::country($keyword['country']??'India'),'hl'=>$language,'deviceType'=>$device,'num'=>10];
 }
 public static function parse(array $data,array $keyword,int $start=0): array {
  if(($data['requestMetadata']['status']??'ok')!=='ok'||isset($data['error'])||!isset($data['organicResults'])||!is_array($data['organicResults']))throw new RuntimeException('HasData did not return valid organic results. Your previous ranking has been kept.');
  $target=$keyword['target_url']?:$keyword['domain'];
  $host=fn($url)=>preg_replace('/^www\./','',strtolower(rtrim((string)parse_url($url,PHP_URL_HOST),'.')));
  $target=SafeHttp::normalize($target);$targetHost=$host($target);
  $result=['keyword_id'=>(int)$keyword['id'],'position'=>null,'url'=>''];
  foreach($data['organicResults'] as $item){
   if(!is_array($item)||!is_int($item['position']??null)||$item['position']<1||!is_string($item['link']??null))throw new RuntimeException('HasData returned an invalid organic result. Your previous ranking has been kept.');
   $link=SafeHttp::normalize($item['link']);$resultHost=$host($link);
   $matches=$resultHost===$targetHost||str_ends_with($resultHost,'.'.$targetHost);
   if(!empty($keyword['target_url']))$matches=$resultHost===$targetHost&&rtrim((string)parse_url($link,PHP_URL_PATH),'/')===rtrim((string)parse_url($target,PHP_URL_PATH),'/')&&parse_url($link,PHP_URL_QUERY)===parse_url($target,PHP_URL_QUERY);
   $position=$start+$item['position'];
   if($matches&&$position<=100&&($result['position']===null||$position<$result['position']))$result=['keyword_id'=>(int)$keyword['id'],'position'=>$position,'url'=>$link];
  }
  return $result;
 }
 public function positions(array $keywords): array {
  if(!cfg('RANKING_API_KEY'))throw new RuntimeException('Add your HasData API key in Administration > Settings.');
  $results=[];
  foreach($keywords as $keyword){
   $params=self::parameters($keyword);
   for($start=0;$start<100;$start+=10){
   $params['start']=$start;
   try{$r=($this->transport??[SafeHttp::class,'request'])('https://api.hasdata.com/scrape/google/serp?'.http_build_query($params),'GET',['Accept: application/json','x-api-key: '.cfg('RANKING_API_KEY')],null,0,null,90);}
   catch(Throwable){throw new RuntimeException('Unable to reach HasData. Please retry shortly. Your previous ranking has been kept.');}
   if($r['status']!==200)throw new RuntimeException(match($r['status']){401,403=>'HasData rejected the API key. Check your key and account access in Administration > Settings.',402=>'HasData credits are exhausted. Refill your HasData account to continue.',429=>'HasData is busy or its request limit was reached. Please retry later.',default=>'HasData could not complete the search (HTTP '.$r['status'].'). Please retry later.'});
   try{$data=json_decode($r['body'],true,64,JSON_THROW_ON_ERROR);}catch(Throwable){throw new RuntimeException('HasData returned unreadable data. Please retry later.');}
   if(!is_array($data))throw new RuntimeException('HasData returned an empty response. Please retry later.');
   $result=self::parse($data,$keyword,$start);
   if($result['position']!==null||empty($data['pagination']['next'])||!$data['organicResults'])break;
   }
   $results[]=$result;
  }
  return $results;
 }
}
