<?php
final class Backlink {
 public static function matches(string $url,string $target): bool {
  $host=fn($u)=>preg_replace('/^www\./','',strtolower((string)parse_url($u,PHP_URL_HOST)));
  return $host($url)===$host($target)&&rtrim((string)parse_url($url,PHP_URL_PATH),'/')===rtrim((string)parse_url($target,PHP_URL_PATH),'/')&&parse_url($url,PHP_URL_QUERY)===parse_url($target,PHP_URL_QUERY);
 }
 public static function parse(string $html,string $source,string $target): array {
  $dom=new DOMDocument();$previous=libxml_use_internal_errors(true);$loaded=$dom->loadHTML('<?xml encoding="utf-8" ?>'.$html,LIBXML_NONET|LIBXML_NOERROR|LIBXML_NOWARNING);libxml_clear_errors();libxml_use_internal_errors($previous);
  if(!$loaded)throw new RuntimeException('Source page could not be parsed.');
  $base=$source;$baseNode=$dom->getElementsByTagName('base')->item(0);if($baseNode)try{$base=SafeHttp::normalize($baseNode->getAttribute('href'),$source);}catch(Throwable){}
  $matches=[];
  foreach($dom->getElementsByTagName('a') as $a){try{$url=SafeHttp::normalize($a->getAttribute('href'),$base);}catch(Throwable){continue;}if(!self::matches($url,$target))continue;
   $rel=preg_split('/\s+/',strtolower(trim($a->getAttribute('rel'))),-1,PREG_SPLIT_NO_EMPTY);
   $matches[]=['anchor'=>mb_substr(trim(preg_replace('/\s+/u',' ',$a->textContent)),0,255),'follow'=>array_intersect($rel,['nofollow','sponsored','ugc'])?'nofollow':'follow','rel'=>implode(' ',$rel),'target_url'=>$url];
  }
  return ['found'=>(bool)$matches,'matches'=>array_slice($matches,0,20),'match_count'=>count($matches)];
 }
 public static function check(array $link): array {
  $result=['checked_at'=>date('Y-m-d H:i:s'),'source_url'=>$link['source_url'],'target_url'=>$link['target_url'],'state'=>'unverified','http_status'=>null,'message'=>''];
  try{
   $source=SafeHttp::normalize($link['source_url']);$target=SafeHttp::normalize($link['target_url']);
   $guard=function($url){$origin=parse_url($url,PHP_URL_SCHEME).'://'.parse_url($url,PHP_URL_HOST);$robots=SafeHttp::request($origin.'/robots.txt','GET',[],null,3);if(!in_array($robots['status'],[200,404,410],true))throw new RuntimeException('Source robots policy could not be verified.');return $robots['status']!==200||Crawler::allowed($url,$robots['body']);};
   $r=SafeHttp::request($source,'GET',[],null,3,$guard);$result['http_status']=$r['status'];$result['final_url']=$r['url'];
   if(in_array($r['status'],[404,410],true)){$result['state']='missing';$result['message']='The source page no longer exists.';}
   elseif($r['status']!==200)throw new RuntimeException('Source returned HTTP '.$r['status'].'. Its previous link status has been kept.');
   elseif(!str_contains(strtolower($r['headers']['content-type']??''),'html'))throw new RuntimeException('Source did not return an HTML page.');
   elseif(preg_match('/<title[^>]*>\s*(?:just a moment|access denied|attention required|robot check)/i',$r['body']))throw new RuntimeException('The source returned an access challenge. Its previous link status has been kept.');
   else{$parsed=self::parse($r['body'],$r['url'],$target);$result+=$parsed;$result['state']=$parsed['found']?'verified':'missing';$result['message']=$parsed['found']?'Target link found in the source HTML.':'Target link was not present in the returned HTML. Check JavaScript-rendered links in your browser.';}
   if($result['state']==='verified'){$first=$result['matches'][0];query("UPDATE backlinks SET status='active',anchor=?,follow=?,last_seen=CURDATE() WHERE id=? AND website_id=?",[$first['anchor'],$first['follow'],$link['id'],$link['website_id']]);}
   elseif($result['state']==='missing')query("UPDATE backlinks SET status='lost' WHERE id=? AND website_id=?",[$link['id'],$link['website_id']]);
  }catch(Throwable $e){$result['message']=mb_substr($e->getMessage(),0,500);}
  if((int)$link['id']>0)Serp::save((int)$link['website_id'],'backlink_check_'.$link['id'],$result);return $result;
 }
 public static function discover(array $w): array {
  $cached=Serp::saved((int)$w['id'],'backlink_discovery');if(($cached['date']??'')===date('Y-m-d')&&($cached['domain']??'')===$w['domain'])return $cached;
  $host=parse_url($w['domain'],PHP_URL_HOST);$data=Serp::search('"'.$host.'" -site:'.$host,$w['country'],$w['language']);
  $result=['date'=>date('Y-m-d'),'domain'=>$w['domain'],'candidates'=>Serp::organic($data)];Serp::save((int)$w['id'],'backlink_discovery',$result);return $result;
 }
}
