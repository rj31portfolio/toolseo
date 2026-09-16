<?php
/** Collect public, business-scoped data without mixing contacts between listings. */
final class LeadCollector {
 public static function collect(array $data,?callable $request=null): array {
  $source=BtoBLeads::text($data,'source_id',10);
  if(!isset(BtoBLeads::SOURCES[$source]))fail('Choose a supported source.');
  if(!value('SELECT id FROM lead_sources WHERE id=? AND enabled=1',[$source]))fail('This lead source is disabled.');
  try{$url=SafeHttp::normalize(BtoBLeads::text($data,'url',1000));}catch(Throwable){fail('Enter a valid listing URL.');}
  $domain=$source==='1'?'indiamart.com':'tradeindia.com';$host=parse_url($url,PHP_URL_HOST);
  if($host!==$domain&&!str_ends_with($host,'.'.$domain))fail('Listing URL must belong to the selected marketplace.');
  $fetch=$request??[SafeHttp::class,'request'];$origin=parse_url($url,PHP_URL_SCHEME).'://'.$host;
  $scope=static fn(string $u):bool=>parse_url($u,PHP_URL_HOST)===$host;
  try {
   $robots=$fetch($origin.'/robots.txt','GET',[],null,1,$scope,8);
   if(!in_array($robots['status'],[200,404,410],true))fail('Listing access policy is unavailable. Retry later.',502);
   $policy=$robots['status']===200?$robots['body']:'';
   $guard=static fn(string $u):bool=>$scope($u)&&Crawler::allowed($u,$policy);
   if(!$guard($url))fail('This listing does not allow automated collection. Import a permitted business list instead.',422);
   $response=$fetch($url,'GET',[],null,1,$guard,15);
   if($response['status']!==200)fail('Listing returned HTTP '.$response['status'].'. Its details could not be collected.',502);
   if(!str_contains(strtolower($response['headers']['content-type']??''),'html'))fail('Listing did not return an HTML page.',502);
   return self::parse($response['body'],$response['url'],$source);
  }catch(HttpError $e){throw $e;}catch(Throwable){fail('Listing could not be reached. Please retry later.',502);}
 }
 private static function scalar(mixed $value): string {
  if(is_array($value))$value=$value['name']??$value['@value']??'';
  return is_string($value)?trim(preg_replace('/[\x00-\x1F\x7F\s]+/u',' ',html_entity_decode(strip_tags($value),ENT_QUOTES|ENT_HTML5,'UTF-8'))??''):'';
 }
 private static function phone(mixed $value): string {
  if(is_array($value)){
   foreach($value as $candidate){$phone=self::phone($candidate);if($phone!=='')return $phone;}
   return '';
  }
  $phone=preg_replace('/^tel:/i','',self::scalar($value));
  return preg_match('/^\+?[0-9 ().-]+$/D',$phone)&&preg_match('/^\d{7,15}$/D',preg_replace('/\D/','',$phone))?$phone:'';
 }
 public static function parse(string $html,string $url,string $source): array {
  $dom=new DOMDocument();$previous=libxml_use_internal_errors(true);
  try{$dom->loadHTML('<?xml encoding="UTF-8">'.$html,LIBXML_NONET|LIBXML_NOERROR|LIBXML_NOWARNING);}finally{libxml_clear_errors();libxml_use_internal_errors($previous);}
  $xpath=new DOMXPath($dom);$nodes=[];$refs=[];
  $walk=function(mixed $node,int $depth=0)use(&$walk,&$nodes,&$refs):void{
   if(!is_array($node)||$depth>24)return;
   if(isset($node['@type']))$nodes[]=$node;
   if(is_string($node['@id']??null)&&count($node)>1)$refs[$node['@id']]=$node;
   foreach($node as $value)if(is_array($value))$walk($value,$depth+1);
  };
  foreach($xpath->query('//script[@type="application/ld+json"]') as $script){$json=json_decode($script->textContent,true,32);if(is_array($json))$walk($json);}
  // Microdata values are gathered only from their own item scope.
  $micro=function(DOMElement $scope)use(&$micro):array{
   $item=['@type'=>preg_split('/\s+/',trim($scope->getAttribute('itemtype')))];
   $visit=function(DOMNode $parent)use(&$visit,&$micro,&$item):void{
    foreach($parent->childNodes as $child){if(!$child instanceof DOMElement)continue;
     $props=preg_split('/\s+/',trim($child->getAttribute('itemprop')));
     $nested=$child->hasAttribute('itemscope');
     $value=$nested?$micro($child):($child->getAttribute('content')?:($child->getAttribute('href')?:$child->textContent));
     foreach($props as $prop)if($prop!=='')$item[$prop]=$value;
     if(!$nested)$visit($child);
    }
   };$visit($scope);return $item;
  };
  foreach($xpath->query('//*[@itemscope and @itemtype]') as $scope)$nodes[]=$micro($scope);
  // IndiaMART renders visible seller data in individual product cards.
  if($source==='1')foreach($xpath->query('//article[contains(concat(" ",normalize-space(@class)," ")," template7-product-card ")]') as $card){
   $name=$xpath->query('.//a[contains(concat(" ",normalize-space(@class)," ")," template7-seller-name ")]',$card)->item(0);
   if(!$name)continue;
   $city=trim($xpath->evaluate('string(.//*[@itemprop="addressLocality"])',$card));
   // A service area is not a verified business address.
   if(preg_match('/^Deals in\b/i',$city))$city='';
   $nodes[]=['@type'=>'LocalBusiness','name'=>$name->textContent,'url'=>$name->getAttribute('href'),
    'category'=>$xpath->evaluate('string(.//a[contains(concat(" ",normalize-space(@class)," ")," template7-product-name ")])',$card),
    'address'=>['addressLocality'=>$city],
    'telephone'=>$xpath->evaluate('string(.//a[starts-with(@href,"tel:")]/@href)',$card),
    'email'=>$xpath->evaluate('string(.//a[starts-with(@href,"mailto:")]/@href)',$card)];
  }
  $resolve=static function(mixed $v)use($refs):mixed{return is_array($v)&&isset($v['@id'],$refs[$v['@id']])?array_replace($refs[$v['@id']],$v):$v;};
  $records=[];
  foreach($nodes as $node){
   $types=array_map(static fn($t)=>is_string($t)?preg_replace('~^https?://schema.org/~','',$t):'',(array)$node['@type']);
   if(!array_intersect($types,['Organization','LocalBusiness','Corporation','Store','ProfessionalService','WholesaleStore','MedicalBusiness','Restaurant','AutoRepair','RealEstateAgent','HomeAndConstructionBusiness']))continue;
   $name=self::scalar($node['legalName']??$node['name']??'');
   if($name===''||preg_match('/^(indiamart|tradeindia|indiamart intermesh|tradeindia\.com|indiamart\.com)(\s+(limited|ltd\.?))?$/i',$name))continue;
   $address=$resolve($node['address']??[]);if(is_array($address)&&array_is_list($address))$address=$resolve($address[0]??[]);
   $r=array_fill_keys(array_keys(BtoBLeads::FIELDS),'');$r['source_id']=$source;$r['business_name']=$name;
   $r['category']=self::scalar($node['category']??'');
   if(is_array($address)){
    $r['city']=self::scalar($address['addressLocality']??'');$r['state']=self::scalar($address['addressRegion']??'');
    $r['address']=implode(', ',array_filter(array_map([self::class,'scalar'],array_intersect_key($address,array_flip(['streetAddress','addressLocality','addressRegion','postalCode','addressCountry'])))));
   }else $r['address']=self::scalar($address);
   $contacts=$node['contactPoint']??[];if(!array_is_list((array)$contacts))$contacts=[$contacts];
   $contact=$resolve($contacts[0]??[]);if(!is_array($contact))$contact=[];
   $email=strtolower(preg_replace('/^mailto:/i','',self::scalar($node['email']??$contact['email']??'')));
   if(filter_var($email,FILTER_VALIDATE_EMAIL)&&strlen($email)<=190)$r['email']=$email;
   $r['phone']=self::phone($node['telephone']??'');
   foreach($contacts as $point){
    if($r['phone']!=='')break;
    $point=$resolve($point);
    if(is_array($point))$r['phone']=self::phone($point['telephone']??'');
   }
   try{$website=SeoExpert::website(self::scalar($node['url']??''));if(!preg_match('/(^|\.)(indiamart\.com|tradeindia\.com)$/i',parse_url($website,PHP_URL_HOST)))$r['website']=$website;}catch(Throwable){}
   $r['provenance']='Public listing: '.$url;
   foreach(BtoBLeads::FIELDS as $key=>$limit)$r[$key]=mb_substr($r[$key],0,$limit);
   $key=BtoBLeads::fingerprint($r);
   if(isset($records[$key])){foreach($r as $field=>$value)if($records[$key][$field]==='')$records[$key][$field]=$value;}
   else $records[$key]=$r;
   if(count($records)>=25)break;
  }
  return array_values($records);
 }
}
