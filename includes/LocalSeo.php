<?php
final class LocalSeo {
 public const VERSION=1;
 public const DAYS=['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
 public const TYPES=['LocalBusiness','Restaurant','Store','Dentist','Plumber','Electrician','HairSalon','AutoRepair','RealEstateAgent','Hotel'];
 public static function text(array $input,string $key,int $max=300): string {
  $value=$input[$key]??'';if(!is_string($value)||!mb_check_encoding($value,'UTF-8')||mb_strlen($value)>$max||preg_match('/[\x00-\x08\x0b\x0c\x0e-\x1f]/',$value))fail('Invalid '.str_replace('_',' ',$key).'.');return trim($value);
 }
 public static function number(array $input,string $key,float $min,float $max,bool $integer=true): int|float|null {
  $value=self::text($input,$key,20);if($value==='')return null;
  if(!preg_match($integer?'/^\d+$/D':'/^\d+(?:\.\d{1,2})?$/D',$value)||!is_finite((float)$value)||(float)$value<$min||(float)$value>$max)fail(ucfirst(str_replace('_',' ',$key)).' must be between '.$min.' and '.$max.'.');return $integer?(int)$value:(float)$value;
 }
 public static function webUrl(string $url): string {
  if($url!==''&&(!filter_var($url,FILTER_VALIDATE_URL)||!in_array(strtolower(parse_url($url,PHP_URL_SCHEME)??''),['http','https'],true)||parse_url($url,PHP_URL_USER)!==null||parse_url($url,PHP_URL_PASS)!==null||preg_match('/[\x00-\x20\x7f]/',$url)))fail('Use a complete HTTP or HTTPS URL without login details.');return $url;
 }
 public static function list(string $text,int $limit): array {
  $items=array_values(array_unique(array_filter(array_map('trim',preg_split('/\r\n|\r|\n/',$text)),fn($item)=>$item!=='')));
  if(count($items)>$limit)fail('Use no more than '.$limit.' entries per list.');foreach($items as $item)if(mb_strlen($item)>200)fail('Keep each list entry under 200 characters.');return $items;
 }
 public static function validate(array $input): array {
  $p=[];foreach(['business_name'=>190,'category'=>100,'street'=>300,'city'=>100,'region'=>100,'postal_code'=>30,'country'=>2,'phone'=>40,'description'=>1500,'website'=>1000,'profile_url'=>1000,'image_url'=>1000,'service_area'=>300,'website_name'=>190,'website_address'=>700,'website_phone'=>40,'directory_name'=>190,'directory_address'=>700,'directory_phone'=>40,'directory_source'=>200,'page_title'=>300,'meta_description'=>600,'h1'=>300,'page_text'=>10000,'existing_schema'=>30000,'last_review_date'=>10] as $key=>$max)$p[$key]=self::text($input,$key,$max);
  if($p['business_name']==='')fail('Business name is required.');
  $p['country']=strtoupper($p['country']);if($p['country']!==''&&!preg_match('/^[A-Z]{2}$/D',$p['country']))fail('Use a two-letter country code, such as IN or US.');
  foreach(['phone','website_phone','directory_phone'] as $key)if($p[$key]!==''&&(!preg_match('/^[+()0-9.\s-]+$/D',$p[$key])||strlen(self::phone($p[$key]))<7||strlen(self::phone($p[$key]))>15))fail('Enter a valid '.str_replace('_',' ',$key).' with 7–15 digits, including country code when available.');
  foreach(['website','profile_url','image_url'] as $key)$p[$key]=self::webUrl($p[$key]);
  foreach(['business_type'=>['storefront','service_area','hybrid'],'schema_type'=>self::TYPES,'mobile_friendly'=>['unknown','yes','no'],'indexable'=>['unknown','yes','no']] as $key=>$choices){$p[$key]=self::text($input,$key,80)?:$choices[0];if(!in_array($p[$key],$choices,true))fail('Invalid '.str_replace('_',' ',$key).'.');}
  foreach(['secondary_categories'=>10,'services'=>30,'keywords'=>30] as $key=>$limit)$p[$key]=self::list(self::text($input,$key,6000),$limit);
  foreach(['review_count','replied_reviews','photo_count'] as $key)$p[$key]=self::number($input,$key,0,10000000);
  $p['rating']=self::number($input,'rating',1,5,false);
  if($p['review_count']===0&&$p['rating']!==null)fail('Leave rating blank when the review count is zero.');
  if($p['replied_reviews']!==null&&($p['review_count']===null||$p['replied_reviews']>$p['review_count']))fail('Enter a total review count at least as large as the replied review count.');
  if($p['last_review_date']!==''){$date=DateTimeImmutable::createFromFormat('!Y-m-d',$p['last_review_date']);if(!$date||$date->format('Y-m-d')!==$p['last_review_date']||$p['last_review_date']>date('Y-m-d'))fail('Enter a valid last-review date today or earlier.');if($p['review_count']===0)fail('Leave last-review date blank when there are no reviews.');}
  $hours=$input['hours']??[];if(!is_array($hours))fail('Invalid opening hours.');$p['hours']=[];
  foreach(self::DAYS as $day){$row=$hours[$day]??[];if(!is_array($row))fail('Invalid hours for '.$day.'.');$state=self::text($row,'state',20)?:'unknown';if(!in_array($state,['unknown','open','closed','all_day'],true))fail('Invalid hours for '.$day.'.');$opens=self::text($row,'opens',5);$closes=self::text($row,'closes',5);
   if($state==='open'&&(!preg_match('/^(?:[01]\d|2[0-3]):[0-5]\d$/D',$opens)||!preg_match('/^(?:[01]\d|2[0-3]):[0-5]\d$/D',$closes)||$opens===$closes))fail('Enter distinct opening and closing times for '.$day.', or choose Open 24 hours.');
   $p['hours'][$day]=['state'=>$state,'opens'=>$state==='open'?$opens:'','closes'=>$state==='open'?$closes:''];
  }
  return $p;
 }
 public static function normal(string $value): string {return preg_replace('/[^\pL\pN]/u','',mb_strtolower($value,'UTF-8'));}
 public static function phone(string $value): string {return preg_replace('/\D/','',$value);}
 public static function address(array $p): string {return $p['business_type']==='service_area'?$p['service_area']:implode(', ',array_filter([$p['street'],$p['city'],$p['region'],$p['postal_code'],$p['country']],fn($v)=>$v!==''));}
 public static function schema(array $p): string {
  $s=['@context'=>'https://schema.org','@type'=>$p['schema_type'],'name'=>$p['business_name']];
  foreach(['description'=>'description','phone'=>'telephone','website'=>'url','image_url'=>'image'] as $field=>$property)if($p[$field]!=='')$s[$property]=$p[$field];
  if($p['website']!=='')$s['@id']=preg_replace('/#.*$/','',$p['website']).'#local-business';
  if($p['profile_url']!=='')$s['sameAs']=[$p['profile_url']];
  if($p['business_type']!=='service_area'){$address=['@type'=>'PostalAddress'];foreach(['street'=>'streetAddress','city'=>'addressLocality','region'=>'addressRegion','postal_code'=>'postalCode','country'=>'addressCountry'] as $key=>$prop)if($p[$key]!=='')$address[$prop]=$p[$key];if(count($address)>1)$s['address']=$address;}
  if($p['service_area']!=='')$s['areaServed']=$p['service_area'];
  foreach($p['hours'] as $day=>$hours){if($hours['state']==='unknown')continue;$opens=$hours['state']==='open'?$hours['opens']:'00:00';$closes=match($hours['state']){'open'=>$hours['closes'],'all_day'=>'23:59',default=>'00:00'};$s['openingHoursSpecification'][]=['@type'=>'OpeningHoursSpecification','dayOfWeek'=>'https://schema.org/'.$day,'opens'=>$opens,'closes'=>$closes];}
  if($p['services'])$s['hasOfferCatalog']=['@type'=>'OfferCatalog','name'=>'Services','itemListElement'=>array_map(fn($name)=>['@type'=>'Offer','itemOffered'=>['@type'=>'Service','name'=>$name]],$p['services'])];
  // Google review totals are audit inputs, not first-party review markup.
  return json_encode($s,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES|JSON_HEX_TAG|JSON_THROW_ON_ERROR);
 }
 public static function existingNode(string $json): array {
  if($json==='')return ['valid'=>null,'node'=>null];
  try{$parsed=json_decode($json,true,64,JSON_THROW_ON_ERROR);}catch(JsonException){return ['valid'=>false,'node'=>null];}
  if(!is_array($parsed))return ['valid'=>false,'node'=>null];
  $queue=array_is_list($parsed)?$parsed:[$parsed];$scanned=0;
  while($queue&&$scanned++<200){$item=array_shift($queue);if(!is_array($item))continue;$types=(array)($item['@type']??[]);if(array_intersect(self::TYPES,array_filter($types,'is_string')))return ['valid'=>true,'node'=>$item];if(isset($item['@graph'])&&is_array($item['@graph']))foreach($item['@graph'] as $entry)$queue[]=$entry;}
  return ['valid'=>true,'node'=>null];
 }
 public static function analyze(array $p): array {
  $groups=[];$checks=[];
  $add=function(string $group,string $label,int $max,?bool $met,string $evidence,string $recommendation)use(&$groups,&$checks){$earned=$met===true?$max:0;$groups[$group]??=['earned'=>0,'max'=>0];$groups[$group]['earned']+=$earned;$groups[$group]['max']+=$max;$checks[]=['group'=>$group,'label'=>$label,'earned'=>$earned,'max'=>$max,'status'=>$met===null?'Not provided':($met?'Met':'Needs attention'),'evidence'=>$evidence,'recommendation'=>$met===true?'Keep this information accurate.':$recommendation];};
  $present=fn($value)=>$value!==''?true:null;
  $profile='Profile completeness';
  foreach(['business_name'=>['Business name entered',3],'category'=>['Primary category entered',3],'description'=>['Business description entered',3],'phone'=>['Phone entered',3],'website'=>['Website entered',3]] as $key=>[$label,$weight])$add($profile,$label,$weight,$present($p[$key]),$p[$key]!==''?'Entered manually.':'Not entered.','Add the accurate '.str_replace('_',' ',$key).' to the profile and this audit.');
  $location=$p['business_type']==='service_area'?$p['service_area']!=='':($p['street']!==''&&$p['city']!==''&&$p['region']!==''&&$p['postal_code']!==''&&$p['country']!=='');
  $add($profile,'Address or service area complete',6,$location,'Business type: '.str_replace('_',' ',$p['business_type']).'.','For a storefront, enter street, city, region, postal code and country. For a service-area business, enter the area served; keep a private address hidden.');
  $known=count(array_filter($p['hours'],fn($h)=>$h['state']!=='unknown'));$operating=count(array_filter($p['hours'],fn($h)=>in_array($h['state'],['open','all_day'],true)));
  $add($profile,'Weekly hours complete',4,$known===0?null:($known===7&&$operating>0),$known.' of 7 days recorded.','Enter each day as open, closed or open 24 hours. Confirm special hours in your actual profile separately.');
  $add($profile,'At least 5 profile photos',3,$p['photo_count']===null?null:$p['photo_count']>=5,$p['photo_count']===null?'Count unknown.':$p['photo_count'].' photos reported.','Add useful, current business photos. Five is an app checklist benchmark, not a Google requirement.');
  $add($profile,'Services listed',2,$p['services']?true:null,count($p['services']).' services entered.','Describe the services you actually offer.');
  $add('Reviews','Rating at least 4.0 / 5',6,$p['rating']===null?null:$p['rating']>=4,$p['rating']===null?'Rating unknown.':$p['rating'].' / 5 reported.','Review recurring customer feedback and improve the experience. The 4.0 threshold is this app’s benchmark.');
  $add('Reviews','At least 10 reviews',5,$p['review_count']===null?null:$p['review_count']>=10,$p['review_count']===null?'Review count unknown.':$p['review_count'].' reviews reported.','Invite genuine feedback from customers without incentives or review gating. Ten reviews is an app benchmark.');
  $age=$p['last_review_date']===''?null:(int)(new DateTimeImmutable($p['last_review_date']))->diff(new DateTimeImmutable('today'))->format('%a');
  $add('Reviews','Review within the last 90 days',4,$age===null?null:$age<=90,$age===null?'Last review date unknown.':$age.' days since the entered review date.','Keep inviting genuine feedback as you serve customers. Ninety days is an app freshness benchmark.');
  $rate=$p['review_count']!==null&&$p['review_count']>0&&$p['replied_reviews']!==null?$p['replied_reviews']/$p['review_count']:null;
  $add('Reviews','At least 80% of reviews replied to',5,$rate===null?null:$rate>=.8,$rate===null?'Reply rate cannot be calculated.':round($rate*100).'% of reported reviews replied to.','Respond helpfully to customer reviews. Enter total and replied counts; 80% is an app benchmark.');
  $reference=['name'=>$p['business_name'],'address'=>self::address($p),'phone'=>$p['phone']];
  foreach(['website'=>[4,4,4],'directory'=>[3,3,2]] as $source=>$weights)foreach(['name','address','phone'] as $index=>$field){$other=$p[$source.'_'.$field];$normal=$field==='phone'?[self::class,'phone']:[self::class,'normal'];$met=$other===''||$reference[$field]===''?null:$normal($other)===$normal($reference[$field]);$add('NAP consistency',ucfirst($source).' '.$field.' matches',$weights[$index],$met,$other===''?'Comparison not entered.':'Compared supplied text; '.($met?'normalized match.':'no normalized match.'),'Compare the business '.($field==='address'&&$p['business_type']==='service_area'?'service area':$field).' with your '. $source.'. Match the full details and phone country code; confirm abbreviations manually.');}
  $add('Website SEO','HTTPS website URL',3,$p['website']===''?null:strtolower(parse_url($p['website'],PHP_URL_SCHEME))==='https',$p['website']?:'Website URL unknown.','Use HTTPS on your business website. This check reads the URL only; it does not test the certificate.');
  foreach(['page_title'=>['Page title length 15–65 characters',2,15,65],'meta_description'=>['Description length 70–170 characters',2,70,170]] as $key=>[$label,$weight,$min,$max]){$length=mb_strlen($p[$key]);$add('Website SEO',$label,$weight,$length===0?null:($length>=$min&&$length<=$max),$length.' characters pasted.','Write clear, useful '.$key.' text. This length range is an app guideline, not a ranking rule.');}
  $add('Website SEO','Main heading supplied',2,$present($p['h1']),$p['h1']!==''?'H1 entered manually.':'H1 not entered.','Paste the actual main heading from your local landing page.');
  $locality=$p['city']?:$p['service_area'];$localContent=$p['page_text']===''||$locality===''?null:mb_stripos($p['page_text'],$locality)!==false;
  $add('Website SEO','Page text mentions locality',2,$localContent,$locality!==''?'Checks pasted text for “'.$locality.'”.':'No locality entered.','Describe where you serve customers naturally in the actual page content, then paste that text here.');
  foreach(['mobile_friendly'=>'Mobile usability confirmed','indexable'=>'Indexability confirmed'] as $key=>$label)$add('Website SEO',$label,2,$p[$key]==='unknown'?null:$p[$key]==='yes','Self-reported: '.$p[$key].'.','Manually check '.($key==='indexable'?'that the page is public and has no noindex directive.':'that text, navigation and forms work on a phone.').' No live website check runs here.');
  $existing=self::existingNode($p['existing_schema']);$node=$existing['node'];$add('Existing schema','Pasted schema is valid JSON',2,$existing['valid'],$p['existing_schema']===''?'No installed schema supplied.':'Checks pasted JSON only.','Paste the actual JSON-LD from your website, without the script tags, and correct any JSON errors.');
  $add('Existing schema','LocalBusiness type found',2,$p['existing_schema']===''?null:$node!==null,$node?'Supported LocalBusiness node found.':'No supported LocalBusiness node found.','Use LocalBusiness or one of the subtypes offered by this generator. A generated draft does not count as installed schema.');
  $namePhone=$node===null?null:(is_string($node['name']??null)&&is_string($node['telephone']??null)&&$p['phone']!==''&&self::normal($node['name'])===self::normal($p['business_name'])&&self::phone($node['telephone'])===self::phone($p['phone']));
  $add('Existing schema','Schema name and phone match',3,$namePhone,'Compared against supplied profile details.','Use the same accurate business name and telephone in your page and schema.');
  $schemaLocation=null;if($node!==null){if($p['business_type']==='service_area')$schemaLocation=$p['service_area']!==''&&is_string($node['areaServed']??null)&&self::normal($node['areaServed'])===self::normal($p['service_area']);else{$a=$node['address']??null;$schemaLocation=is_array($a)&&$location;if($schemaLocation)foreach(['street'=>'streetAddress','city'=>'addressLocality','region'=>'addressRegion','postal_code'=>'postalCode','country'=>'addressCountry'] as $key=>$property){$actual=$a[$property]??'';if($property==='addressCountry'&&is_array($actual))$actual=$actual['name']??'';if(!is_string($actual)||self::normal($actual)!==self::normal($p[$key]))$schemaLocation=false;}}}
  $add('Existing schema','Schema location matches',2,$schemaLocation,'Compared supplied address or service area.','Keep your public address or service area consistent. Review other valid structured formats manually.');
  $schemaUrl=$node===null?null:($p['website']!==''&&is_string($node['url']??null)&&rtrim($node['url'],'/')===rtrim($p['website'],'/'));
  $add('Existing schema','Schema website matches',1,$schemaUrl,'Compares supplied website URLs.','Use the correct canonical business website URL in schema.');
  $add('Local keywords','Target keywords entered',2,$p['keywords']?true:null,count($p['keywords']).' target keywords.','Add relevant service or product phrases customers use.');
  $localized=$p['keywords']&&$locality!==''?count(array_filter($p['keywords'],fn($k)=>mb_stripos($k,$locality)!==false))>0:null;
  $add('Local keywords','Locality included in target keywords',2,$localized,$locality!==''?'Looks for “'.$locality.'”.':'Locality not provided.','Include a relevant city or service area in some target phrases, without keyword stuffing.');
  $copy=$p['page_title'].' '.$p['h1'].' '.$p['page_text'];$covered=$p['keywords']&&trim($copy)!==''?count(array_filter($p['keywords'],fn($k)=>mb_stripos($copy,$k)!==false))>0:null;
  $add('Local keywords','Target phrase found in page copy',1,$covered,'Checks only pasted title, H1 and page text.','Use relevant target phrases naturally in actual page copy.');
  $ideas=[];foreach(array_slice(array_unique(array_filter(array_merge([$p['category']],$p['services']))),0,8) as $term){$ideas[]=trim($term.' '.$locality);if($locality!=='')$ideas[]=trim($term.' in '.$locality);}
  return ['version'=>self::VERSION,'captured_at'=>date('Y-m-d H:i:s'),'source'=>'Manual entries only; no Google or website API calls.','profile'=>$p,'score'=>array_sum(array_column($groups,'earned')),'groups'=>$groups,'checks'=>$checks,'issues'=>array_values(array_filter($checks,fn($check)=>$check['status']!=='Met')),'keyword_ideas'=>array_slice(array_values(array_unique($ideas)),0,12),'schema'=>self::schema($p)];
 }
}
