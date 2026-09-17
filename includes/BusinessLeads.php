<?php
final class BusinessLeads {
 public const SOURCES=['google-maps'=>'Google Maps','yelp'=>'Yelp','yellow-pages'=>'Yellow Pages'];
 public static function parameters(string $source,string $keyword,string $location,int $page): array {
  if(!isset(self::SOURCES[$source]))throw new InvalidArgumentException('Choose a supported service.');
  return $source==='google-maps'?['q'=>$keyword.' in '.$location,'start'=>($page-1)*20]:array_merge(['keyword'=>$keyword,'location'=>$location],$source==='yelp'?['start'=>($page-1)*10]:['page'=>$page]);
 }
 public static function parse(array $data): array {
  if(isset($data['error'])||isset($data['errors'])||isset($data['requestMetadata']['status'])&&$data['requestMetadata']['status']!=='ok')throw new RuntimeException('The lead service could not complete this search.');
  $items=$data['localResults']??$data['searchResults']??$data['placesResults']??null;
  if(!is_array($items)||!array_is_list($items))throw new RuntimeException('The lead service returned an unexpected response. Please retry later.');
  $out=[];$text=static fn($v,$n)=>is_scalar($v)?mb_substr(trim((string)$v),0,$n):'';
  foreach(array_slice($items,0,100) as $item){if(!is_array($item))continue;$name=$text($item['title']??$item['name']??'',250);if($name==='')continue;
   $address=$item['address']??'';if(is_array($address))$address=implode(', ',array_filter($address,'is_string'));
   $r=['business_name'=>$name,'phone'=>$text($item['phone']??$item['phoneNumber']??'',100),'website'=>Launch::safeUrl($item['website']??''),'address'=>$text($address,1000),'listing_url'=>Launch::safeUrl($item['url']??$item['link']??'')];
   $key=hash('sha256',mb_strtolower($name.'|'.$r['address'].'|'.$r['phone']));$out[$key]=$r;
  }return $out;
 }
 public static function search(string $source,string $keyword,string $location,int $page,?callable $fetch=null): array {
  $key=cfg('LEADS_API_KEY')?:cfg('RANKING_API_KEY');if(!$key)fail('Lead search is not configured. Add the lead service key in server configuration.',503);
  $path=['google-maps'=>'google-maps','yelp'=>'yelp','yellow-pages'=>'yellowpages'][$source]??'';
  $params=self::parameters($source,$keyword,$location,$page);
  try{$r=($fetch??[SafeHttp::class,'request'])('https://api.hasdata.com/scrape/'.$path.'/search?'.http_build_query($params),'GET',['Accept: application/json','x-api-key: '.$key],null,0,null,90);}catch(Throwable){fail('Lead search is temporarily unavailable. Please retry.',502);}
  if($r['status']!==200)fail(match($r['status']){401,403=>'Lead service credentials need attention.',402=>'Lead service credits are exhausted.',429=>'Search limit reached. Please retry later.',default=>'Lead service could not complete the request.'},502);
  try{$data=json_decode($r['body'],true,64,JSON_THROW_ON_ERROR);if(!is_array($data))throw new RuntimeException();return self::parse($data);}catch(Throwable){fail('Lead service returned incomplete results. Please retry.',502);}
 }
}
