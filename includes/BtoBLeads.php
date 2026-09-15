<?php
/** Authorized lead imports only. No marketplace crawler or live provider is configured. */
final class BtoBLeads {
 public const SOURCES = ['1'=>'IndiaMART','2'=>'TradeIndia'];
 public const FIELDS = ['business_name'=>190,'category'=>190,'city'=>120,'state'=>120,'website'=>500,'email'=>190,'phone'=>40,'provenance'=>1000];
 public static function ready(): bool { return (bool)value("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='lead_activity'"); }
 public static function migrate(): void {
  foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents(ROOT.'/database/migrations/009-b2b-leads.sql')) as $sql) if(trim($sql)!=='') query($sql);
  foreach(['lead_email'=>'email','lead_phone'=>'phone','lead_website'=>'website(190)'] as $name=>$column)if(!value('SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema=DATABASE() AND table_name=\'leads\' AND index_name=?',[$name]))query('ALTER TABLE leads ADD INDEX '.$name.' ('.$column.')');
 }
 public static function text(array $data,string $key,int $max): string {
  $v=$data[$key]??'';
  if(!is_string($v)||!mb_check_encoding($v,'UTF-8')||mb_strlen($v)>$max||preg_match('/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]/',$v)) fail('Invalid '.str_replace('_',' ',$key).'.');
  return trim($v);
 }
 public static function validate(array $data): array {
  $r=[];foreach(self::FIELDS as $key=>$max)$r[$key]=self::text($data,$key,$max);
  foreach(['business_name','provenance'] as $key)if($r[$key]==='')fail(ucfirst(str_replace('_',' ',$key)).' is required.');
  if($r['city']===''&&$r['state']==='')fail('Enter a city or state.');
  $source=self::text($data,'source_id',10);if(!isset(self::SOURCES[$source]))fail('Choose IndiaMART or TradeIndia.');$r['source_id']=(int)$source;
  if($r['website']!==''){try{$r['website']=SeoExpert::website($r['website']);}catch(Throwable){fail('Enter a public HTTP or HTTPS website URL.');}}
  $r['email']=strtolower($r['email']);if($r['email']!==''&&!filter_var($r['email'],FILTER_VALIDATE_EMAIL))fail('Invalid public business email.');
  if($r['phone']!==''&&(!preg_match('/^\+?[0-9 ()\.\-]+$/D',$r['phone'])||!preg_match('/^[0-9]{7,15}$/D',preg_replace('/\D/','',$r['phone']))))fail('Use a business phone with 7–15 digits.');
  $r['fingerprint']=self::fingerprint($r);
  return $r;
 }
 public static function fingerprint(array $r): string {
  $normalize=fn($s)=>mb_strtolower(preg_replace('/[^\pL\pN]/u','',$s));
  return hash('sha256',implode('|',array_map($normalize,[$r['business_name'],$r['city'],$r['state']])));
 }
 public static function scoring(array $r): array {
  $score=($r['website']!==''?20:0)+($r['email']!==''?20:0)+($r['phone']!==''?20:0);
  if($r['business_name']!==''&&$r['category']!==''&&$r['city']!==''&&$r['state']!=='')$score+=20;
  if(isset($r['website_available'])&&(int)$r['website_available']===1)$score+=10;
  if(isset($r['seo_score']))$score+=(int)round((100-(int)$r['seo_score'])/10);
  return ['score'=>$score,'rating'=>$score>=70?'Hot':($score>=40?'Warm':'Normal')];
 }
 public static function activity(?int $id,int $uid,string $action,array $details=[]): void {
  query('INSERT INTO lead_activity(lead_id,user_id,action,details) VALUES (?,?,?,?)',[$id,$uid,$action,json_encode($details,JSON_THROW_ON_ERROR)]);
 }
 public static function get(int $id,bool $lock=false): array {
  $r=row('SELECT l.*,s.name AS source FROM leads l JOIN lead_sources s ON s.id=l.source_id WHERE l.id=?'.($lock?' FOR UPDATE':''),[$id]);
  if(!$r)fail('Lead not found.',404);return $r;
 }
 public static function save(array $data,int $uid,int $id=0): int {
  $r=self::validate($data);$old=$id?self::get($id,true):null;
  if(!value('SELECT id FROM lead_sources WHERE id=? AND enabled=1',[$r['source_id']]))fail('This lead source is disabled.');
  if(value('SELECT id FROM leads WHERE fingerprint=? AND id<>?',[$r['fingerprint'],$id]))fail('Duplicate business and location. Edit the existing lead instead.',409);
  $seo=$old&&$old['website']===$r['website']?array_intersect_key($old,array_flip(['seo_score','website_available'])):[];
  $r+=self::scoring($r+$seo);
  try {
   if($id){$set=implode(',',array_map(fn($k)=>$k.'=?',array_keys($r)));query('UPDATE leads SET '.$set.($old['website']!==$r['website']?',seo_score=NULL,website_available=NULL,seo_result=NULL,audited_at=NULL':'').',demo_slot=NULL WHERE id=?',[...array_values($r),$id]);}
   else {query('INSERT INTO leads ('.implode(',',array_keys($r)).',created_by) VALUES ('.implode(',',array_fill(0,count($r)+1,'?')).')',[...array_values($r),$uid]);$id=(int)db()->lastInsertId();}
  } catch(PDOException $e){if(($e->errorInfo[1]??0)===1062)fail('Duplicate business and location.',409);throw $e;}
  self::activity($id,$uid,$old?'edited':'created');return $id;
 }
 public static function filters(array $data): array {
  $where=['1=1'];$params=[];
  foreach(['keyword','location','category','source_id','rating','website','email','phone','from','to','favorite','duplicates'] as $key)$f[$key]=self::text($data,$key,190);
  $like=fn($s)=>'%'.str_replace(['!','%','_'],['!!','!%','!_'],$s).'%';
  if($f['keyword']!==''){$where[]="(l.business_name LIKE ? ESCAPE '!' OR l.category LIKE ? ESCAPE '!')";array_push($params,$like($f['keyword']),$like($f['keyword']));}
  if($f['location']!==''){$where[]="(l.city LIKE ? ESCAPE '!' OR l.state LIKE ? ESCAPE '!')";array_push($params,$like($f['location']),$like($f['location']));}
  if($f['category']!==''){$where[]="l.category LIKE ? ESCAPE '!'";$params[]=$like($f['category']);}
  foreach(['source_id'=>array_keys(self::SOURCES),'rating'=>['Hot','Warm','Normal'],'website'=>['yes','no'],'email'=>['yes','no'],'phone'=>['yes','no'],'favorite'=>['1'],'duplicates'=>['1']] as $key=>$allowed){
   if($f[$key]==='')continue;if(!in_array($f[$key],array_map('strval',$allowed),true))fail('Invalid '.$key.' filter.');
   if(in_array($key,['website','email','phone']))$where[]='l.'.$key.($f[$key]==='yes'?"<>''":"=''");
   elseif($key==='duplicates')$where[]="EXISTS (SELECT 1 FROM leads d WHERE d.id<>l.id AND ((l.email<>'' AND d.email=l.email) OR (l.website<>'' AND d.website=l.website) OR (l.phone<>'' AND d.phone=l.phone)))";
   else {$where[]='l.'.$key.'=?';$params[]=$f[$key];}
  }
  foreach(['from','to'] as $key)if($f[$key]!==''){try{SeoExpert::date($f[$key]);}catch(Throwable){fail('Invalid date filter.');}$where[]='l.created_at'.($key==='from'?'>=?':'<DATE_ADD(?,INTERVAL 1 DAY)');$params[]=$f[$key];}
  if($f['from']!==''&&$f['to']!==''&&$f['from']>$f['to'])fail('Start date must precede end date.');
  return [implode(' AND ',$where),$params,$f];
 }
 public static function demo(array $data): array {
  $keyword=self::text($data,'keyword',190);$location=self::text($data,'location',190);$source=self::text($data,'source_id',10);
  if($keyword===''||$location==='')fail('Enter a keyword and location.');if(!isset(self::SOURCES[$source]))fail('Choose a source.');
  // A fixed cohort prevents public pagination, query changes or source changes exposing the database.
  $pool=rows('SELECT business_name,category,city,state,website,email,phone,s.name AS source,l.source_id,score,rating FROM leads l JOIN lead_sources s ON s.id=l.source_id WHERE demo_slot BETWEEN 1 AND 5 ORDER BY demo_slot LIMIT 5');
  $results=array_values(array_filter($pool,fn($r)=>(int)$r['source_id']===(int)$source&&mb_stripos($r['business_name'].' '.$r['category'],$keyword)!==false&&mb_stripos($r['city'].' '.$r['state'],$location)!==false));
  foreach($results as &$r)unset($r['source_id']);unset($r);
  query('INSERT INTO lead_searches(keyword,location,source_id,result_count,is_public) VALUES (?,?,?,?,1)',[$keyword,$location,$source,count($results)]);
  return $results;
 }
 public static function import(string $path,array $data,int $uid): array {
  if(filesize($path)>2097152)fail('CSV must be at most 2 MB.');
  $fp=fopen($path,'rb');if(!$fp)fail('Cannot read uploaded CSV.');
  try {
   $header=fgetcsv($fp,0,',','"','');if(!$header)fail('CSV is empty.');$header[0]=preg_replace('/^\xEF\xBB\xBF/','',$header[0]);
   $header=array_map('trim',$header);if(count($header)!==count(array_unique($header)))fail('Duplicate CSV headings.');
   if(!in_array('business_name',$header,true))fail('CSV requires business_name header.');
   foreach($header as $h)if(!isset(self::FIELDS[$h]))fail('Unknown CSV column: '.$h);
   $prepared=[];$line=1;
   while(($cells=fgetcsv($fp,0,',','"',''))!==false){$line++;if($cells===[null])continue;if($line>1001)fail('Import at most 1,000 rows at a time.');if(count($cells)!==count($header))fail('Wrong column count on CSV row '.$line.'.');
    $record=array_combine($header,$cells);$record['source_id']=$data['source_id']??'';$record['provenance']=$data['provenance']??'';
    try{$prepared[]=self::validate($record);}catch(HttpError $e){fail('CSV row '.$line.': '.$e->getMessage());}
   }
  }finally{fclose($fp);}
  if(!$prepared)fail('CSV has no lead rows.');$added=0;$duplicates=0;
  db()->beginTransaction();
  try {foreach($prepared as $r){$r['source_id']=(string)$r['source_id'];try{self::save($r,$uid);$added++;}catch(HttpError $e){if($e->getCode()!==409)throw $e;$duplicates++;}}
   self::activity(null,$uid,'imported',compact('added','duplicates'));db()->commit();
  }catch(Throwable $e){db()->rollBack();throw $e;}
  return compact('added','duplicates');
 }
 public static function analyze(int $id,int $uid): void {
  $lead=self::get($id);if(!$lead['website'])fail('This lead has no website.');
  $host=parse_url($lead['website'],PHP_URL_HOST);$origin=parse_url($lead['website'],PHP_URL_SCHEME).'://'.$host;
  $guard=static function(string $url) use($host): bool { $h=parse_url($url,PHP_URL_HOST);return $h===$host&&!preg_match('/(^|\.)(indiamart\.com|tradeindia\.com)$/i',$h); };
  if(!$guard($lead['website']))fail('Marketplace URLs cannot be audited through the lead extractor.');
  // Reuse the existing SSRF-safe HTTP client, robots rules, page parser and SEO audit checks.
  try {
   $robots=SafeHttp::request($origin.'/robots.txt','GET',[],null,2,$guard,8);
   if(!in_array($robots['status'],[200,404,410],true))fail('Website robots policy could not be verified. Try again later.');
   $policy=$robots['status']===200?$robots['body']:'';
   $pageGuard=fn($url)=>$guard($url)&&Crawler::allowed($url,$policy);
   if(!$pageGuard($lead['website']))fail('Website robots.txt does not permit this audit.');
   $response=SafeHttp::request($lead['website'],'GET',[],null,2,$pageGuard,10);
   $available=$response['status']>=200&&$response['status']<300;
   $sitemap='Not checked (robots policy)';
   if($available&&$pageGuard($origin.'/sitemap.xml')){try{$sm=SafeHttp::request($origin.'/sitemap.xml','GET',[],null,2,$pageGuard,8);$xml=new DOMDocument();$prev=libxml_use_internal_errors(true);$valid=$sm['status']===200&&!str_contains(strtoupper($sm['body']),'<!DOCTYPE')&&$xml->loadXML($sm['body'],LIBXML_NONET)&&in_array($xml->documentElement->localName,['urlset','sitemapindex'],true);libxml_clear_errors();libxml_use_internal_errors($prev);$sitemap=$valid?'Found at /sitemap.xml':'Not found at /sitemap.xml';}catch(Throwable){$sitemap='Could not verify /sitemap.xml';}}
   $result=self::snapshot($response,$origin,$robots['status'],$sitemap);$score=$result['seo_score'];
  } catch(HttpError $e){throw $e;}catch(Throwable $e){error_log('B2B audit: '.$e->getMessage());fail('Website audit could not complete. No score was assigned; retry later.',502);}
  db()->beginTransaction();try{$current=self::get($id,true);if($current['website']!==$lead['website'])fail('Website changed during audit. Run it again.',409);$rating=self::scoring(array_replace($current,['seo_score'=>$score,'website_available'=>(int)$available]));query('UPDATE leads SET seo_score=?,website_available=?,seo_result=?,audited_at=NOW(),score=?,rating=? WHERE id=?',[$score,(int)$available,json_encode($result,JSON_THROW_ON_ERROR),$rating['score'],$rating['rating'],$id]);self::activity($id,$uid,'website_analyzed',['seo_score'=>$score]);db()->commit();}catch(Throwable $e){db()->rollBack();throw $e;}
 }
 public static function snapshot(array $response,string $origin,int $robotsStatus,string $sitemap): array {
  $available=$response['status']>=200&&$response['status']<300;
  $html=$available&&str_contains(strtolower($response['headers']['content-type']??''),'text/html')&&trim($response['body'])!=='';
  $p=$html?Crawler::parse($response,$origin):null;$score=$p?Audit::pageScore($p):null;
  $issues=$p?Audit::checks($p):[['title'=>$available?'HTML page not available for analysis':'Website returned HTTP '.$response['status'],'severity'=>'high','fix'=>'Verify the website URL and server response, then run the audit again.']];
  return ['seo_score'=>$score,'meta_title'=>$p['title']??'Not checked','meta_description'=>$p['description']??'Not checked','h1'=>$p['h1']??'Not checked','sitemap'=>$sitemap,'robots'=>$robotsStatus===200?'Found':'Not found (HTTP '.$robotsStatus.')','ssl'=>str_starts_with($response['url'],'https://')?'HTTPS with verified certificate':'HTTP; no SSL','load_ms'=>$response['ms'],'mobile_viewport'=>$p?($p['details']['viewport']?:'Missing'):'Not checked','http_status'=>$response['status'],'website_availability'=>$available?'Available':'Unavailable','issues'=>$issues,'scope'=>'Single-page audit using the existing SEO audit engine. Fetch timing and viewport checks are basic checks, not Core Web Vitals or a rendered mobile test.','prospect'=>$score===null?'No SEO score assigned; verify website availability':($score<70?'SEO improvement opportunity':'Review issues before qualifying')];
 }
 public static function csvCell(mixed $v): string { $s=(string)($v??'');return preg_match('/^[\s\x{FEFF}]*[=+@\-]/u',$s)?"'".$s:$s; }
}
