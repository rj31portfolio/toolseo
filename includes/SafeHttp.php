<?php
final class SafeHttp {
 public static function normalize(string $url,?string $base=null): string {
  $url=trim(html_entity_decode($url,ENT_QUOTES|ENT_HTML5,'UTF-8'));
  if (preg_match('/[\x00-\x20\x7f\\\\]/',$url)) throw new RuntimeException('URL contains invalid characters.');
  if ($base && !preg_match('~^[a-z][a-z0-9+.-]*:~i',$url)) {
   $b=parse_url($base); $origin=$b['scheme'].'://'.$b['host'];
   if (str_starts_with($url,'//')) $url=$b['scheme'].':'.$url;
   elseif (str_starts_with($url,'/')) $url=$origin.$url;
   elseif (str_starts_with($url,'?')) $url=$origin.($b['path']??'/').$url;
   elseif ($url==='' || str_starts_with($url,'#')) $url=$base;
   else $url=$origin.preg_replace('~/[^/]*$~','/',($b['path']??'/')).$url;
  }
  $p=parse_url($url);
  if (!$p || !in_array(strtolower($p['scheme']??''),['http','https'],true)||empty($p['host'])||isset($p['user'])||isset($p['pass'])) throw new RuntimeException('Only public HTTP and HTTPS URLs are allowed.');
  $scheme=strtolower($p['scheme']); $host=strtolower(rtrim($p['host'],'.'));
  if (isset($p['port']) && $p['port']!==($scheme==='https'?443:80)) throw new RuntimeException('Only standard HTTP/HTTPS ports are allowed.');
  $segments=[]; foreach(explode('/',$p['path']??'/') as $segment) { if($segment==='..') array_pop($segments); elseif($segment!=='.') $segments[]=$segment; }
  $path=implode('/',$segments); if($path==='') $path='/';
  return $scheme.'://'.$host.$path.(isset($p['query'])?'?'.$p['query']:'');
 }
 public static function publicIp(string $ip): bool { return filter_var($ip,FILTER_VALIDATE_IP,FILTER_FLAG_NO_PRIV_RANGE|FILTER_FLAG_NO_RES_RANGE)!==false && !str_contains($ip,':') && !preg_match('/^(0|100\.6[4-9]|100\.[7-9][0-9]|100\.1[01][0-9]|100\.12[0-7]|192\.0\.0|198\.1[89])\./',$ip); }
 public static function resolve(string $host): array {
  if (filter_var($host,FILTER_VALIDATE_IP)) $ips=[$host];
  else { if (!preg_match('/^(?=.{1,253}$)(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z]{2,63}$/i',$host)) throw new RuntimeException('A public domain name is required.'); $records=@dns_get_record($host,DNS_A); $ips=array_column($records?:[],'ip'); }
  if (!$ips) throw new RuntimeException('DNS resolution failed.');
  foreach($ips as $ip) if(!self::publicIp($ip)) throw new RuntimeException('Private, local, reserved and unsupported addresses are blocked.');
  return $ips;
 }
 public static function request(string $url,string $method='GET',array $headers=[],?string $body=null,int $redirects=5,?callable $guard=null,int $timeout=20): array {
  $seen=[]; $started=microtime(true);
  for($i=0;$i<=$redirects;$i++) {
   $url=self::normalize($url); if($guard && !$guard($url)) throw new RuntimeException('URL blocked by crawl scope or robots.txt.'); if(isset($seen[$url])) throw new RuntimeException('Redirect loop detected.'); $seen[$url]=true;
   $p=parse_url($url); $ips=self::resolve($p['host']); $port=$p['scheme']==='https'?443:80; $data=''; $responseHeaders=[]; $overflow=false;
   $ch=curl_init($url);
   curl_setopt_array($ch,[CURLOPT_CUSTOMREQUEST=>$method,CURLOPT_HTTPHEADER=>$headers,CURLOPT_FOLLOWLOCATION=>false,CURLOPT_CONNECTTIMEOUT=>5,CURLOPT_TIMEOUT=>max(1,min(120,$timeout)),CURLOPT_PROTOCOLS=>CURLPROTO_HTTP|CURLPROTO_HTTPS,CURLOPT_SSL_VERIFYPEER=>true,CURLOPT_SSL_VERIFYHOST=>2,CURLOPT_PROXY=>'',CURLOPT_USERAGENT=>'SEOAutoPilotBot/1.0',CURLOPT_RESOLVE=>[$p['host'].':'.$port.':'.$ips[0]],CURLOPT_WRITEFUNCTION=>function($ch,$chunk)use(&$data,&$overflow){ if(strlen($data)+strlen($chunk)>2097152){$overflow=true;return 0;} $data.=$chunk; return strlen($chunk); },CURLOPT_HEADERFUNCTION=>function($ch,$line)use(&$responseHeaders){$parts=explode(':',$line,2);if(count($parts)===2)$responseHeaders[strtolower(trim($parts[0]))]=trim($parts[1]);return strlen($line);}]);
   if($body!==null) curl_setopt($ch,CURLOPT_POSTFIELDS,$body);
   $ok=curl_exec($ch); $error=curl_error($ch); $status=(int)curl_getinfo($ch,CURLINFO_RESPONSE_CODE); curl_close($ch);
   if($ok===false) throw new RuntimeException($overflow?'Response exceeds 2 MB limit.':'Network request failed: '.$error);
   if($status>=300 && $status<400 && isset($responseHeaders['location'])) { if($method!=='GET') throw new RuntimeException('Provider redirects are not permitted.'); $url=self::normalize($responseHeaders['location'],$url); continue; }
   return ['url'=>$url,'status'=>$status,'body'=>$data,'headers'=>$responseHeaders,'redirects'=>array_keys($seen),'ms'=>(int)((microtime(true)-$started)*1000)];
  }
  throw new RuntimeException('Maximum redirect count exceeded.');
 }
}
