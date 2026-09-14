<?php
final class InstagramDownloader {
 public const MAX_BYTES=52428800;
 public static function settings(): array {
  $defaults=['name'=>'Instagram Post & Reel Downloader','slug'=>'instagram-downloader','description'=>'Paste a public Instagram post or reel link to find the image or video available in its public page metadata.','enabled'=>true,'visible'=>true];
  $saved=setting('instagram_downloader_service',[]);
  return array_replace($defaults,is_array($saved)?array_intersect_key($saved,$defaults):[]);
 }
 public static function normalize(string $url): string {
  $url=trim($url);
  if(strlen($url)>2048||preg_match('/[\x00-\x20\x7f\\\\]/',$url))throw new InvalidArgumentException('Paste a valid public Instagram post or reel URL.');
  $p=parse_url($url);
  if(!$p||strtolower($p['scheme']??'')!=='https'||!in_array(strtolower($p['host']??''),['instagram.com','www.instagram.com'],true)||isset($p['user'])||isset($p['pass'])||isset($p['port'])||!preg_match('~^/(p|reel)/([A-Za-z0-9_-]{1,64})/?$~D',$p['path']??'', $match))throw new InvalidArgumentException('Use https://www.instagram.com/p/…/ or https://www.instagram.com/reel/…/. Profiles, stories and private links are not supported.');
  return 'https://www.instagram.com/'.$match[1].'/'.$match[2].'/';
 }
 public static function mediaUrl(string $url): string {
  if(strlen($url)>8192||preg_match('/[\x00-\x20\x7f\\\\]/',$url))throw new RuntimeException('The media URL is invalid.');
  $p=parse_url($url);$host=strtolower($p['host']??'');
  if(!$p||($p['scheme']??'')!=='https'||isset($p['user'])||isset($p['pass'])||isset($p['port'])||isset($p['fragment'])||!preg_match('/^(?:[a-z0-9-]+\.)+(?:cdninstagram\.com|fbcdn\.net)$/D',$host))throw new RuntimeException('The page did not expose a supported Instagram media URL.');
  return $url;
 }
 public static function pageAllowed(string $target,string $original): bool {
  try{return self::normalize($target)===$original;}catch(Throwable){return false;}
 }
 public static function extract(string $url,?callable $request=null): array {
  $url=self::normalize($url);
  $request??=fn($target)=>SafeHttp::request($target,'GET',['Accept: text/html'],null,2,fn($next)=>self::pageAllowed($next,$url),10);
  try{$response=$request($url);}catch(Throwable){throw new RuntimeException('Instagram could not be reached or redirected to a restricted page. Login, CAPTCHA and other access controls are not bypassed.');}
  if(in_array($response['status'],[401,403,429],true))throw new RuntimeException('Instagram blocked anonymous access or limited requests. Please try again later. This tool cannot bypass the restriction.');
  if(in_array($response['status'],[404,410],true))throw new RuntimeException('This post is unavailable, removed or private. Only publicly accessible posts and reels are supported.');
  if($response['status']!==200||!self::pageAllowed($response['url']??$url,$url))throw new RuntimeException('Instagram did not return a publicly accessible post page.');
  if(!str_contains(strtolower($response['headers']['content-type']??'text/html'),'text/html'))throw new RuntimeException('Instagram returned an unexpected page format.');
  return self::parse($response['body'],$url);
 }
 public static function parse(string $html,string $url): array {
  $previous=libxml_use_internal_errors(true);$doc=new DOMDocument();
  try{$loaded=$doc->loadHTML('<?xml encoding="UTF-8">'.$html,LIBXML_NONET|LIBXML_NOERROR|LIBXML_NOWARNING);}finally{libxml_clear_errors();libxml_use_internal_errors($previous);}
  if(!$loaded)throw new RuntimeException('Instagram returned an unreadable page.');
  $xpath=new DOMXPath($doc);$meta=[];
  foreach($xpath->query('//head/meta[@property or @name]') as $tag){$key=strtolower($tag->getAttribute('property')?:$tag->getAttribute('name'));$meta[$key][]=trim($tag->getAttribute('content'));}
  $heading=strtolower(($meta['og:title'][0]??'').' '.$xpath->evaluate('string(//title)').' '.$xpath->evaluate('string(//h1)'));
  if(preg_match('/log\s*in|sign\s*in|captcha|challenge|private account|account is private|page isn.t available|content isn.t available/',$heading)||$xpath->query('//input[@type="password"]')->length||preg_match('/"is_private"\s*:\s*true/',$html))throw new RuntimeException('Instagram requires login or restricts this content. Private accounts, CAPTCHA and access controls are not supported.');
  if(isset($meta['og:url'][0])&&!self::pageAllowed($meta['og:url'][0],$url))throw new RuntimeException('Instagram returned a different page instead of the requested public post.');
  $find=function(string $type)use($meta):?string{foreach([$type.':secure_url',$type,$type.':url'] as $key)foreach($meta[$key]??[] as $candidate)try{return self::mediaUrl($candidate);}catch(RuntimeException){}return null;};
  $image=$find('og:image');$video=$find('og:video');
  if(!$image&&!$video)throw new RuntimeException('No downloadable og:image or og:video metadata was available. Instagram may require login, block automated access or omit the media.');
  $reel=str_contains($url,'/reel/');
  return ['title'=>mb_substr($meta['og:title'][0]??'Instagram media',0,500),'source'=>$url,'thumbnail'=>$image,'type'=>$video?'video':'image','media'=>$video??$image,'notice'=>$video?'Only the video exposed in public page metadata is available.':($reel?'Only a preview image was exposed. The reel video is unavailable; this downloads the preview image.':'Only the image exposed in public page metadata is available; carousel items are not enumerated.')];
 }
 /** Fetch only a media URL previously extracted by the server, with bounded storage and verified MIME. */
 public static function download(string $url,string $type): array {
  $seen=[];
  for($redirect=0;$redirect<=2;$redirect++){
   $url=self::mediaUrl($url);if(isset($seen[$url]))throw new RuntimeException('The media server returned a redirect loop.');$seen[$url]=true;
   $host=parse_url($url,PHP_URL_HOST);$ips=SafeHttp::resolve($host);$file=tmpfile();if(!$file)throw new RuntimeException('Temporary download storage is unavailable.');
   $headers=[];$bytes=0;$overflow=false;$ch=curl_init($url);
   curl_setopt_array($ch,[CURLOPT_FOLLOWLOCATION=>false,CURLOPT_CONNECTTIMEOUT=>5,CURLOPT_TIMEOUT=>30,CURLOPT_PROTOCOLS=>CURLPROTO_HTTPS,CURLOPT_SSL_VERIFYPEER=>true,CURLOPT_SSL_VERIFYHOST=>2,CURLOPT_PROXY=>'',CURLOPT_USERAGENT=>'SEOAutoPilotBot/1.0',CURLOPT_RESOLVE=>[$host.':443:'.$ips[0]],CURLOPT_HEADERFUNCTION=>function($ch,$line)use(&$headers){$parts=explode(':',$line,2);if(count($parts)===2)$headers[strtolower(trim($parts[0]))]=trim($parts[1]);return strlen($line);},CURLOPT_WRITEFUNCTION=>function($ch,$chunk)use($file,&$bytes,&$overflow){$bytes+=strlen($chunk);if($bytes>self::MAX_BYTES){$overflow=true;return 0;}return fwrite($file,$chunk);}]);
   $ok=curl_exec($ch);$status=(int)curl_getinfo($ch,CURLINFO_RESPONSE_CODE);curl_close($ch);
   if($ok===false){fclose($file);throw new RuntimeException($overflow?'The media exceeds the 50 MB download limit.':'The media download timed out or could not be completed.');}
   if($status>=300&&$status<400&&isset($headers['location'])){fclose($file);$url=SafeHttp::normalize($headers['location'],$url);continue;}
   if($status!==200||!$bytes){fclose($file);throw new RuntimeException('Instagram blocked the media or its link expired. Check the post again; restricted media cannot be downloaded.');}
   rewind($file);$prefix=fread($file,8192);$mime=(new finfo(FILEINFO_MIME_TYPE))->buffer($prefix);rewind($file);
   $allowed=$type==='video'?['video/mp4'=>'mp4','video/webm'=>'webm']:['image/jpeg'=>'jpg','image/png'=>'png','image/webp'=>'webp','image/gif'=>'gif'];
   if(!isset($allowed[$mime])){fclose($file);throw new RuntimeException('The server returned an unsupported file instead of the expected media.');}
   return ['file'=>$file,'bytes'=>$bytes,'mime'=>$mime,'extension'=>$allowed[$mime]];
  }
  throw new RuntimeException('The media server redirected too many times.');
 }
}
