<?php
final class SeoFiles {
 public static function lines(string $text,int $limit): array {
  $lines=array_values(array_filter(array_map('trim',preg_split('/\r\n|\r|\n/',$text)),fn($line)=>$line!==''));
  if(count($lines)>$limit)fail('Use no more than '.$limit.' non-empty lines.');
  return array_values(array_unique($lines));
 }
 public static function url(string $url): string {
  if(strlen($url)>=2048||preg_match('/[^\x21-\x7e]|[<>"\\\\]|%(?![a-f0-9]{2})/i',$url))fail('Use valid, percent-encoded HTTP or HTTPS URLs under 2,048 characters.');
  $p=parse_url($url);
  if(!$p||!in_array(strtolower($p['scheme']??''),['http','https'],true)||empty($p['host'])||isset($p['user'])||isset($p['pass'])||isset($p['fragment'])||!filter_var($url,FILTER_VALIDATE_URL))fail('Enter complete HTTP or HTTPS URLs without fragments or login details.');
  $scheme=strtolower($p['scheme']);$port=$p['port']??($scheme==='https'?443:80);
  if($port!==($scheme==='https'?443:80))fail('Use the standard HTTP or HTTPS port.');
  return $scheme.'://'.strtolower($p['host']).($p['path']??'/').(isset($p['query'])?'?'.$p['query']:'');
 }
 public static function sitemap(string $domain,string $input,string $lastmod=''): array {
  $base=self::url($domain);$urls=self::lines($input,1000);if(!$urls)fail('Add at least one page URL.');
  if($lastmod!==''){$date=DateTimeImmutable::createFromFormat('!Y-m-d',$lastmod);if(!$date||$date->format('Y-m-d')!==$lastmod||$lastmod>date('Y-m-d'))fail('Last modified must be a valid date today or earlier.');}
  $clean=[];foreach($urls as $url){$url=self::url($url);if(parse_url($url,PHP_URL_HOST)!==parse_url($base,PHP_URL_HOST)||parse_url($url,PHP_URL_SCHEME)!==parse_url($base,PHP_URL_SCHEME))fail('All page URLs must use the selected website’s exact host and protocol.');$clean[$url]=true;}
  $doc=new DOMDocument('1.0','UTF-8');$doc->formatOutput=true;$root=$doc->createElementNS('http://www.sitemaps.org/schemas/sitemap/0.9','urlset');$doc->appendChild($root);
  foreach(array_keys($clean) as $url){$entry=$doc->createElement('url');$loc=$doc->createElement('loc');$loc->appendChild($doc->createTextNode($url));$entry->appendChild($loc);if($lastmod!=='')$entry->appendChild($doc->createElement('lastmod',$lastmod));$root->appendChild($entry);}
  return ['reply'=>$doc->saveXML(),'count'=>count($clean),'filename'=>'sitemap.xml'];
 }
 public static function robots(string $agents,string $disallow,string $allow,string $sitemaps): array {
  $bots=self::lines($agents,20);if(!$bots)fail('Add a user-agent, or use * for all crawlers.');$lines=[];
  foreach($bots as $bot){if(!preg_match('/^(?:\*|[A-Za-z0-9_.-]{1,80})$/D',$bot))fail('Use one crawler name per line, such as Googlebot, or *.');$lines[]='User-agent: '.$bot;}
  $blocked=self::lines($disallow,200);$allowed=self::lines($allow,200);
  foreach(['Disallow'=>$blocked,'Allow'=>$allowed] as $directive=>$paths)foreach($paths as $path){if(!str_starts_with($path,'/')||preg_match('/[\x00-\x20\x7f#]/',$path)||strlen($path)>2000)fail('Rules must start with / and contain no spaces, comments or control characters.');$lines[]=$directive.': '.$path;}
  if(!$blocked&&!$allowed)$lines[]='Disallow:';
  $maps=self::lines($sitemaps,20);if($maps)$lines[]='';foreach($maps as $map)$lines[]='Sitemap: '.self::url($map);
  return ['reply'=>implode("\n",$lines)."\n",'filename'=>'robots.txt','count'=>count($blocked)+count($allowed)];
 }
 public static function crawlUrls(array $website): array {
  $job=value("SELECT id FROM crawl_jobs WHERE website_id=? AND status='completed' ORDER BY id DESC LIMIT 1",[$website['id']]);if(!$job)return [];
  $pages=query('SELECT url,canonical FROM pages WHERE website_id=? AND job_id=? AND http_status=200 AND noindex=0 ORDER BY id',[$website['id'],$job]);$urls=[];
  while($page=$pages->fetch()){try{$url=self::url($page['url']);if(self::sitemap($website['domain'],$url)['count']!==1)continue;
   if($page['canonical']){$canonical=$page['canonical'];if(!preg_match('~^https?://~i',$canonical))$canonical=SafeHttp::normalize($canonical,$url);if(self::url($canonical)!==$url)continue;}
   $urls[$url]=true;if(count($urls)>1000)break;
  }catch(RuntimeException){continue;}}
  return array_keys($urls);
 }
}
