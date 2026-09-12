<?php
final class Crawler {
 public static function allowed(string $url,string $robots): bool {
  $groups=[]; $agents=[]; $rules=[]; $hasRules=false;
  foreach(explode("\n",$robots) as $line){$line=trim(explode('#',$line,2)[0]);if(!str_contains($line,':'))continue;[$k,$v]=array_map('trim',explode(':',$line,2));$k=strtolower($k);
   if($k==='user-agent'){if($hasRules){$groups[]=[$agents,$rules];$agents=[];$rules=[];$hasRules=false;}$agents[]=strtolower($v);}
   elseif(in_array($k,['allow','disallow'])&&$agents){$hasRules=true;if($v!=='')$rules[]=[$k,$v];}
  } $groups[]=[$agents,$rules]; $specific=[];$wild=[];
  foreach($groups as [$agents,$rules]) {if(in_array('seoautopilotbot',$agents))$specific=array_merge($specific,$rules);elseif(in_array('*',$agents))$wild=array_merge($wild,$rules);}
  $path=(parse_url($url,PHP_URL_PATH)?:'/').(parse_url($url,PHP_URL_QUERY)?'?'.parse_url($url,PHP_URL_QUERY):''); $allow=true;$length=-1;
  foreach($specific?:$wild as [$type,$rule]){ $end=str_ends_with($rule,'$');$pattern=str_replace('\\*','.*',preg_quote($end?substr($rule,0,-1):$rule,'~'));if(preg_match('~^'.$pattern.($end?'$':'').'~',$path) && (strlen($rule)>$length || (strlen($rule)===$length&&$type==='allow'))){$length=strlen($rule);$allow=$type==='allow';}}
  return $allow;
 }
 public static function parse(array $response,string $origin): array {
  $dom=new DOMDocument(); $previous=libxml_use_internal_errors(true); $dom->loadHTML('<?xml encoding="UTF-8">'.$response['body'],LIBXML_NONET|LIBXML_NOERROR|LIBXML_NOWARNING); libxml_clear_errors();libxml_use_internal_errors($previous);$x=new DOMXPath($dom);
  $text=fn(string $q)=>trim($x->evaluate('string('.$q.')'));$count=fn(string $q)=>(int)$x->evaluate('count('.$q.')');
  $internal=[];$external=[]; foreach($x->query('//a[@href]') as $a){try{$u=SafeHttp::normalize($a->getAttribute('href'),$response['url']);if(parse_url($u,PHP_URL_HOST)===parse_url($origin,PHP_URL_HOST))$internal[$u]=true;else$external[$u]=true;}catch(Throwable){}}
  $images=[];foreach($x->query('//img[@src]') as $img){try{$images[]=['url'=>SafeHttp::normalize($img->getAttribute('src'),$response['url']),'alt'=>$img->getAttribute('alt')];}catch(Throwable){}}
  $hreflangValid=true;foreach($x->query('//link[@hreflang]') as $link){if(!preg_match('/^(?:[a-z]{2,3}(?:-[a-z]{2})?|x-default)$/i',$link->getAttribute('hreflang'))) $hreflangValid=false;try{SafeHttp::normalize($link->getAttribute('href'));}catch(Throwable){$hreflangValid=false;}}
  $extra=['images'=>$images,'hreflang_valid'=>$hreflangValid];
  foreach(iterator_to_array($x->query('//script|//style|//nav|//footer')) as $node) $node->parentNode->removeChild($node);
  $body=trim(preg_replace('/\s+/u',' ',$dom->textContent));$robots=$text('//meta[translate(@name,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")="robots"]/@content');
  return ['url'=>$response['url'],'http_status'=>$response['status'],'title'=>$text('//title'),'description'=>$text('//meta[@name="description"]/@content'),'h1'=>$text('//h1'),'h2'=>implode(' | ',array_map(fn($n)=>trim($n->textContent),iterator_to_array($x->query('//h2')))),'word_count'=>count(preg_split('/\s+/u',$body,-1,PREG_SPLIT_NO_EMPTY)),'image_count'=>$count('//img'),'missing_alt'=>$count('//img[not(@alt) or normalize-space(@alt)=""]'),'internal_links'=>array_keys($internal),'external_links'=>array_keys($external),'canonical'=>$text('//link[@rel="canonical"]/@href'),'robots'=>$robots,'schema_count'=>substr_count(strtolower($response['body']),'application/ld+json'),'og_count'=>$count('//meta[starts-with(@property,"og:")]'),'noindex'=>(int)str_contains(strtolower($robots.' '.($response['headers']['x-robots-tag']??'')),'noindex'),'load_ms'=>$response['ms'],'details'=>$extra+['h1_count'=>$count('//h1'),'viewport'=>$text('//meta[@name="viewport"]/@content'),'language'=>$text('//html/@lang'),'hreflang'=>$count('//link[@hreflang]'),'twitter'=>$count('//meta[starts-with(@name,"twitter:")]'),'mixed_content'=>$count('//*[@src[starts-with(.,"http://")]]'),'redirects'=>$response['redirects'],'text'=>mb_substr($body,0,16000)]];
 }
 public static function start(array $w): int {
  db()->beginTransaction(); query('SELECT id FROM users WHERE id=? FOR UPDATE',[$w['user_id']]);
  if($active=value("SELECT id FROM crawl_jobs WHERE website_id=? AND status IN ('queued','running')",[$w['id']])){db()->commit();return (int)$active;}
  $p=plan((int)$w['user_id']);query('INSERT INTO crawl_jobs (website_id,max_pages) VALUES (?,?)',[$w['id'],min(25000,(int)$p['crawl_pages'])]);$id=(int)db()->lastInsertId();query('INSERT INTO crawl_urls(job_id,url,url_hash) VALUES (?,?,?)',[$id,$w['domain'],hash('sha256',$w['domain'])]);db()->commit();return $id;
 }
 public static function work(?int $jobId=null,int $batchPages=PHP_INT_MAX): void {
  if(!value("SELECT GET_LOCK('seo_crawl_worker',0)"))return;
  try {
   $job=row("SELECT j.*,w.domain,w.user_id FROM crawl_jobs j JOIN websites w ON w.id=j.website_id WHERE j.status IN ('queued','running')".($jobId!==null?' AND j.id=?':'')." ORDER BY j.id LIMIT 1",$jobId!==null?[$jobId]:[]);if(!$job)return;
   query("UPDATE crawl_jobs SET status='running',heartbeat=NOW() WHERE id=?",[$job['id']]);
   if($job['robots']===null){$origin=parse_url($job['domain'],PHP_URL_SCHEME).'://'.parse_url($job['domain'],PHP_URL_HOST);$r=SafeHttp::request($origin.'/robots.txt');if($r['status']>=500)throw new RuntimeException('Robots.txt unavailable; crawl stopped conservatively.');$job['robots']=$r['status']===200?$r['body']:'';
    try{$s=SafeHttp::request($origin.'/sitemap.xml');$xml=$s['status']===200?@simplexml_load_string($s['body'],SimpleXMLElement::class,LIBXML_NONET):false;$sitemap=['status'=>$s['status'],'valid'=>$xml!==false];if($xml!==false)foreach($xml->xpath('//*[local-name()="url"]/*[local-name()="loc"]')?:[] as $loc){try{$u=SafeHttp::normalize((string)$loc);if(parse_url($u,PHP_URL_HOST)===parse_url($job['domain'],PHP_URL_HOST))self::enqueue($job,$u);}catch(Throwable){}}}catch(Throwable $e){$sitemap=['status'=>0,'valid'=>false];}
    query('UPDATE crawl_jobs SET robots=?,sitemap=? WHERE id=?',[$job['robots'],json_encode($sitemap),$job['id']]);
   }
   $end=time()+45;$batch=0;
   while(time()<$end && $job['processed']<$job['max_pages'] && $batch<$batchPages){
    $next=row("SELECT * FROM crawl_urls WHERE job_id=? AND status='queued' ORDER BY id LIMIT 1",[$job['id']]);if(!$next)break;
    $batch++;
    if(!self::allowed($next['url'],$job['robots'])){query("UPDATE crawl_urls SET status='blocked' WHERE id=?",[$next['id']]);continue;}
    try{$r=SafeHttp::request($next['url'],'GET',[],null,5,fn($u)=>parse_url($u,PHP_URL_HOST)===parse_url($job['domain'],PHP_URL_HOST)&&self::allowed($u,$job['robots']));if(!str_contains(strtolower($r['headers']['content-type']??''),'text/html') && !str_contains(strtolower($r['headers']['content-type']??''),'application/xhtml'))throw new RuntimeException('Non-HTML response skipped.');
     $p=self::parse($r,$job['domain']);$p['score']=Audit::pageScore($p);$cols=array_keys($p);$values=array_map(fn($v)=>is_array($v)?json_encode($v):$v,array_values($p));query('INSERT IGNORE INTO pages (website_id,job_id,url_hash,'.implode(',',$cols).') VALUES ('.implode(',',array_fill(0,count($values)+3,'?')).')',array_merge([$job['website_id'],$job['id'],hash('sha256',$p['url'])],$values));
     foreach($p['internal_links'] as $u)self::enqueue($job,$u);query("UPDATE crawl_urls SET status='done' WHERE id=?",[$next['id']]);
    }catch(Throwable $e){query("UPDATE crawl_urls SET status='failed',error=? WHERE id=?",[mb_substr($e->getMessage(),0,500),$next['id']]);}
    $job['processed']++;query('UPDATE crawl_jobs SET processed=?,heartbeat=NOW() WHERE id=?',[$job['processed'],$job['id']]);usleep(max(200,min(5000,(int)setting('crawl_delay_ms',1000)))*1000);
   }
   if($job['processed']>=$job['max_pages']||!value("SELECT id FROM crawl_urls WHERE job_id=? AND status='queued' LIMIT 1",[$job['id']])){if(!value('SELECT id FROM pages WHERE job_id=? LIMIT 1',[$job['id']]))throw new RuntimeException('No pages could be fetched. Review the crawl URL errors and robots.txt.');Resources::check((int)$job['id']);Audit::run((int)$job['id']);query("UPDATE crawl_jobs SET status='completed',completed_at=NOW() WHERE id=?",[$job['id']]);notify((int)$job['user_id'],'Your SEO audit is ready.','/audit?website_id='.$job['website_id']);}
  }catch(Throwable $e){if(isset($job['id']))query("UPDATE crawl_jobs SET status='failed',error=? WHERE id=?",[$e->getMessage(),$job['id']]);error_log((string)$e);}finally{value("SELECT RELEASE_LOCK('seo_crawl_worker')");}
 }
 private static function enqueue(array $job,string $url): void {if(strlen($url)>2000)return;if((int)value('SELECT COUNT(*) FROM crawl_urls WHERE job_id=?',[$job['id']])>=$job['max_pages'])return;query('INSERT IGNORE INTO crawl_urls(job_id,url,url_hash) VALUES (?,?,?)',[$job['id'],$url,hash('sha256',$url)]);}
}
