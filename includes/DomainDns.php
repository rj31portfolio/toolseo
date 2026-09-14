<?php
final class DomainDns {
 public const TYPES=['A'=>1,'AAAA'=>28,'CNAME'=>5,'MX'=>15,'NS'=>2,'TXT'=>16,'SOA'=>6,'CAA'=>257];
 public static function settings(): array {
  $defaults=['name'=>'Domain & DNS Checker','slug'=>'domain-dns-checker','description'=>'Check public domain ownership, registration dates, nameservers and DNS records. Free, with no login required.','enabled'=>true,'visible'=>true];
  $saved=setting('domain_dns_service',[]);
  return array_replace($defaults,is_array($saved)?array_intersect_key($saved,$defaults):[]);
 }
 public static function validateSlug(string $slug): string {
  if(!preg_match('/^[a-z][a-z0-9]*(?:-[a-z0-9]+)*$/D',$slug)||strlen($slug)>80)throw new InvalidArgumentException('Use a lowercase slug of up to 80 characters, with letters, numbers and hyphens.');
  $reserved=['index','index.php','install','api','accept-invitation','invoice','login','register','forgot-password','reset-password','verify-email','logout','features','pricing','how-it-works','seo-tools','about','contact','blog','terms','privacy','refund-policy','cookie-policy','sitemap','sitemap.xml','tools','no-api-tools','services','dashboard','websites','website','report','billing','profile','notifications','subscription','project-settings','assets','public','auth','config','includes','database','storage','tests','cron','vendor','uploads'];
  if(str_starts_with($slug,'admin')||in_array($slug,$reserved,true)||isset(WorkspaceUI::catalog()[$slug])||file_exists(ROOT.'/'.$slug))throw new InvalidArgumentException('This slug is already used. Choose another.');
  return $slug;
 }
 public static function domain(string $input): string {
  $domain=rtrim(trim($input),'.');
  if(preg_match('/[^\x00-\x7f]/',$domain)){
   if(!function_exists('idn_to_ascii'))throw new InvalidArgumentException('Enter international domains in their ASCII (xn--) form.');
   $domain=idn_to_ascii($domain,IDNA_DEFAULT,INTL_IDNA_VARIANT_UTS46)?:'';
  }
  $domain=strtolower($domain);
  if(strlen($domain)>253||!preg_match('/^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+(?:[a-z]{2,63}|xn--[a-z0-9-]{2,59})$/D',$domain)||filter_var($domain,FILTER_VALIDATE_IP)||preg_match('/\.(?:localhost|local|internal|test|invalid|example|onion)$/D',$domain))throw new InvalidArgumentException('Enter a public domain such as example.com, without a URL, port or path.');
  return $domain;
 }
 public static function lookup(string $input,string $type,?callable $request=null): array {
  $domain=self::domain($input);
  if($type!=='RDAP'&&!isset(self::TYPES[$type]))throw new InvalidArgumentException('Unsupported record type.');
  $url=$type==='RDAP'?'https://rdap.org/domain/'.rawurlencode($domain):'https://dns.google/resolve?'.http_build_query(['name'=>$domain,'type'=>self::TYPES[$type],'edns_client_subnet'=>'0.0.0.0/0']);
  $request??=fn($url)=>SafeHttp::request($url,'GET',['Accept: application/rdap+json, application/json'],null,3,fn($target)=>str_starts_with($target,'https://'),8);
  $response=$request($url);
  if($response['status']===404&&$type==='RDAP')return ['domain'=>$domain,'type'=>$type,'message'=>'No RDAP record was found for this exact domain. Try the registered domain if you entered a subdomain. This does not confirm availability.'];
  if($response['status']!==200)throw new RuntimeException('The provider is temporarily unavailable or has limited requests. Please try again later.');
  try{$data=json_decode($response['body'],true,64,JSON_THROW_ON_ERROR);}catch(Throwable){throw new RuntimeException('The provider returned an invalid response. Please try again.');}
  if(!is_array($data))throw new RuntimeException('The provider returned an invalid response.');
  if($type==='RDAP')return self::rdap($domain,$data)+['source'=>$response['url']??$url];
  return self::dns($domain,$type,$data);
 }
 public static function rdap(string $domain,array $data): array {
  if(($data['objectClassName']??'')!=='domain')throw new RuntimeException('The provider did not return a domain registration record.');
  $fields=['Domain'=>$data['unicodeName']??$data['ldhName']??$domain,'Registrar'=>'Not published','Registrant / organization'=>'Not published or redacted','Registration date'=>'Not published','Expiry date'=>'Not published','Last changed'=>'Not published','Domain status'=>implode(', ',$data['status']??[])?:'Not published','Nameservers'=>implode(', ',array_map(fn($ns)=>$ns['ldhName']??$ns['unicodeName']??'', $data['nameservers']??[]))?:'Not published'];
  foreach($data['events']??[] as $event){$label=['registration'=>'Registration date','expiration'=>'Expiry date','last changed'=>'Last changed'][$event['eventAction']??'']??null;if($label)$fields[$label]=$event['eventDate']??'Not published';}
  foreach($data['entities']??[] as $entity){
   $roles=$entity['roles']??[];$names=[];
   foreach($entity['vcardArray'][1]??[] as $property)if(in_array($property[0]??'',['fn','org'],true)){$val=$property[3]??'';if(is_array($val))$val=implode(', ',array_filter($val,'is_string'));if(is_string($val)&&$val!=='')$names[]=$val;}
   if($names&&in_array('registrar',$roles,true))$fields['Registrar']=implode(' / ',array_unique($names));
   if($names&&in_array('registrant',$roles,true))$fields['Registrant / organization']=implode(' / ',array_unique($names));
  }
  return ['domain'=>$domain,'type'=>'RDAP','fields'=>$fields];
 }
 public static function dns(string $domain,string $type,array $data): array {
  if(!isset($data['Status'])||!is_int($data['Status']))throw new RuntimeException('The DNS provider returned an invalid response.');
  if($data['Status']!==0&&$data['Status']!==3)throw new RuntimeException('DNS lookup failed (status '.$data['Status'].'). Please try again later.');
  $records=[];
  foreach($data['Answer']??[] as $answer)if(($answer['type']??null)===self::TYPES[$type])$records[]=['name'=>$answer['name']??$domain,'ttl'=>$answer['TTL']??0,'data'=>$answer['data']??''];
  return ['domain'=>$domain,'type'=>$type,'records'=>$records,'message'=>$data['Status']===3?'NXDOMAIN: this name does not exist in DNS.':($records?'':'No '.$type.' records returned for this name.'),'source'=>'https://dns.google/'];
 }
}
