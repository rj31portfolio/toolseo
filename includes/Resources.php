<?php
final class Resources {
 public static function check(int $jobId): void {
  $pages=rows('SELECT * FROM pages WHERE job_id=? LIMIT 500',[$jobId]);$queue=[];
  foreach($pages as $p){foreach(json_decode($p['external_links'],true)??[] as $url)$queue[$url]='external';$d=json_decode($p['details'],true);foreach($d['images']??[] as $image)if(!empty($image['url']))$queue[$image['url']]='image';}
  // Keep optional resource checks bounded so the worker fits shared-hosting cron windows.
  foreach(array_slice($queue,0,100,true) as $url=>$kind)query('INSERT IGNORE INTO resource_checks(job_id,url,url_hash,kind) VALUES (?,?,?,?)',[$jobId,$url,hash('sha256',$url),$kind]);
  $deadline=time()+20;
  foreach(rows('SELECT * FROM resource_checks WHERE job_id=? AND checked_at IS NULL LIMIT 10',[$jobId]) as $r){if(time()>$deadline)break;try{$host=parse_url($r['url'],PHP_URL_SCHEME).'://'.parse_url($r['url'],PHP_URL_HOST);$robots=SafeHttp::request($host.'/robots.txt');if($robots['status']>=500||($robots['status']===200&&!Crawler::allowed($r['url'],$robots['body'])))throw new RuntimeException('Resource check blocked by robots.txt or robots availability.');$response=SafeHttp::request($r['url'],'HEAD',[],null,0);query('UPDATE resource_checks SET http_status=?,content_type=?,size_bytes=?,checked_at=NOW() WHERE id=?',[$response['status'],mb_substr($response['headers']['content-type']??'',0,190),isset($response['headers']['content-length'])?(int)$response['headers']['content-length']:null,$r['id']]);}catch(Throwable $e){query('UPDATE resource_checks SET error=?,checked_at=NOW() WHERE id=?',[$e->getMessage(),$r['id']]);}}
 }
 public static function issues(array $job,array $pages): array {
  $all=[];$status=[];$inbound=[];$titles=[];
  $add=function($p,$code,$title,$severity,$category,$why,$fix)use(&$all){$all[]=[$p,compact('code','title','severity','category','why','fix')];};
  foreach($pages as $p){$status[$p['url']]=$p['http_status'];foreach(json_decode($p['internal_links'],true)??[] as $url)$inbound[$url]=($inbound[$url]??0)+1;}
  $root=value('SELECT domain FROM websites WHERE id=?',[$job['website_id']]);$checks=rows('SELECT * FROM resource_checks WHERE job_id=?',[$job['id']]);$resources=[];foreach($checks as $c)$resources[$c['url']]=$c;
  foreach($pages as $p){$d=json_decode($p['details'],true);foreach(json_decode($p['internal_links'],true)??[] as $url)if(($status[$url]??0)>=400)$add($p,'broken_internal','Broken internal link','high','linking','A linked URL returns an HTTP error: '.$url,'Update or remove the broken link.');
   foreach(json_decode($p['external_links'],true)??[] as $url)if(($resources[$url]['http_status']??0)>=400)$add($p,'broken_external','External link returns an error','medium','linking','A checked external URL returned an error: '.$url.' Some sites block automated checks.','Verify in a browser before replacing the link.');
   foreach($d['images']??[] as $image){$r=$resources[$image['url']]??null;if(($r['size_bytes']??0)>500000)$add($p,'large_image','Image exceeds 500 KB','medium','performance','A checked image has a large declared response size.','Compress and resize the image to its display dimensions.');if(in_array(strtolower(pathinfo(parse_url($image['url'],PHP_URL_PATH)??'',PATHINFO_EXTENSION)),['bmp','tiff','tif']))$add($p,'image_format','Review image format','low','performance','Legacy image formats can increase transfer size.','Use an appropriate web image format with a compatible fallback.');}
   if($p['url']!==$root&&!isset($inbound[$p['url']]))$add($p,'orphan_candidate','No inbound links in this crawl','medium','linking','The page has no inbound links among the crawled pages. Crawl limits can create false positives.','Check discovery paths and add relevant internal links where appropriate.');
   if(str_contains($p['url'],'?')||preg_match('/[A-Z_]/',parse_url($p['url'],PHP_URL_PATH)?:''))$add($p,'url_structure','Review URL structure','opportunity','technical','Parameters or inconsistent URL naming can create duplicate variants.','Prefer stable, descriptive URLs; do not change URLs without a redirect plan.');
   $alternate=str_ends_with($p['url'],'/')?rtrim($p['url'],'/'):$p['url'].'/';if(isset($status[$alternate]))$add($p,'trailing_slash','Both trailing-slash variants were crawled','medium','technical','Multiple URL variants can split signals.','Choose a consistent canonical URL and redirect duplicates.');
   if(($d['hreflang']??0)>0 && !($d['hreflang_valid']??true))$add($p,'hreflang','Invalid hreflang declaration','medium','technical','Invalid language or destination values may be ignored.','Use valid language-region codes and absolute alternate URLs; verify reciprocity.');
  }
  if($pages && trim($job['robots']??'')==='')$add($pages[0],'robots','No robots.txt rules available','opportunity','technical','No robots rules were returned from the standard location. An absent file allows crawling.','Publish robots.txt when you need crawl directives or a sitemap declaration.');
  foreach(rows("SELECT url,error FROM crawl_urls WHERE job_id=? AND status='failed'",[$job['id']]) as $r){if(str_contains(strtolower($r['error']??''),'redirect'))$add($pages[0],'redirect_failure','Redirect could not be followed','high','technical',$r['url'].': '.$r['error'],'Fix redirect loops or excessive redirect chains.');}
  return $all;
 }
}
