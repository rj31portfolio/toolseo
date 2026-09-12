<?php
final class Audit {
 public static function checks(array $p): array {
  $d=is_array($p['details'])?$p['details']:json_decode($p['details'],true);$links=is_array($p['internal_links'])?$p['internal_links']:json_decode($p['internal_links'],true);$issues=[];
  $add=function($condition,$code,$title,$severity,$category,$why,$fix)use(&$issues){if($condition)$issues[]=compact('code','title','severity','category','why','fix');};
  $add(!str_starts_with($p['url'],'https:'),'https','Page uses HTTP','high','technical','Unencrypted pages expose traffic in transit.','Serve this page over HTTPS and redirect HTTP.');
  $add($p['http_status']>=400,'http_error','HTTP error '.$p['http_status'],'critical','technical','Search engines cannot index an unavailable page.','Restore the page or redirect to a relevant replacement.');
  $add(count($d['redirects']??[])>2,'redirect_chain','Redirect chain','medium','technical','Extra hops increase latency and complicate crawling.','Link directly to the final destination.');
  $add(!$p['title'],'missing_title','Missing title','high','onpage','Titles describe a page in search results.','Write a unique, descriptive title.');
  $add(mb_strlen($p['title'])>60,'long_title','Long title','low','onpage','Long titles may be truncated.','Aim for a concise title around 30–60 characters; display width varies.');
  $add($p['title'] && mb_strlen($p['title'])<20,'short_title','Short title','low','onpage','The title may not describe the page sufficiently.','Add a clear topic and useful context.');
  $add(!$p['description'],'missing_description','Missing meta description','medium','onpage','A useful description can communicate value in search snippets.','Write a relevant summary of this page.');
  $add(mb_strlen($p['description'])>160,'long_description','Long meta description','low','onpage','The summary may be truncated.','Make the description concise and specific.');
  $add(!$p['h1'],'missing_h1','Missing H1','high','onpage','A main heading helps readers understand the page.','Add one clear main heading.');
  $add(($d['h1_count']??0)>1,'multiple_h1','Multiple H1 headings','low','onpage','The main topic may be unclear.','Review the heading hierarchy.');
  $add(!$p['h2'],'missing_h2','No section headings','opportunity','content','Sections improve navigation through longer content.','Use descriptive H2 headings where appropriate.');
  $add($p['word_count']<300,'thin_content','Low word count','medium','content','Limited copy may not satisfy intent; some page types need little text.','Review whether the content fully answers the visitor’s question.');
  $add($p['noindex'],'noindex','Page marked noindex','high','technical','This directive asks search engines not to index the page.','Confirm intent before changing the directive.');
  $add(!$p['canonical'],'missing_canonical','Canonical not declared','medium','technical','Canonical hints help consolidate equivalent URLs.','Declare the preferred indexable URL.');
  if($p['canonical']){try{$canonical=SafeHttp::normalize($p['canonical'],$p['url']);$bad=parse_url($canonical,PHP_URL_HOST)!==parse_url($p['url'],PHP_URL_HOST);}catch(Throwable){$bad=true;}$add($bad,'canonical_review','Review canonical destination','high','technical','A different or invalid canonical can affect indexing.','Verify that the canonical URL is intentional and accessible.');}
  $add($p['missing_alt']>0,'missing_alt','Images missing descriptive alt text','medium','onpage','Alternative text helps accessibility and image understanding.','Describe informative images; keep decorative image alt empty.');
  $add(!$p['og_count'],'open_graph','Open Graph tags missing','opportunity','onpage','Shared links may have less useful previews.','Add og:title, og:description and og:image.');
  $add(!($d['twitter']??0),'twitter','Twitter card metadata missing','opportunity','onpage','Social previews may be incomplete.','Add appropriate card metadata.');
  $add(!$p['schema_count'],'schema','No JSON-LD detected','opportunity','onpage','Structured data can explain eligible page entities.','Add relevant, valid schema; rich results are not guaranteed.');
  $add(!($d['viewport']??''),'viewport','Mobile viewport missing','high','technical','Mobile layouts may render at desktop width.','Add a responsive viewport declaration.');
  $add(!($d['language']??''),'language','Document language missing','low','technical','Language declarations help assistive technology.','Set the correct lang attribute on the html element.');
  $add(($d['mixed_content']??0)>0 && str_starts_with($p['url'],'https:'),'mixed_content','Insecure embedded resources','high','technical','HTTP resources on HTTPS pages may be blocked.','Serve embedded resources over HTTPS.');
  $add($p['load_ms']>3000,'slow_response','Slow fetch response','medium','performance','A slow fetch can delay crawling; this is not a Core Web Vitals measurement.','Investigate server response time and response size.');
  $add(count($links??[])===0,'internal_links','No internal links found','medium','linking','Internal links help discovery and navigation.','Link to relevant pages on your website.');
  return $issues;
 }
 public static function pageScore(array $p): int {return max(0,100-array_sum(array_map(fn($i)=>['critical'=>25,'high'=>12,'medium'=>6,'low'=>2,'opportunity'=>0][$i['severity']],self::checks($p))));}
 public static function run(int $jobId): int {
  $job=row('SELECT * FROM crawl_jobs WHERE id=?',[$jobId]);if(!$job)throw new RuntimeException('Crawl not found.');$existing=value('SELECT id FROM seo_audits WHERE job_id=?',[$jobId]);if($existing)return (int)$existing;
  $pages=rows('SELECT * FROM pages WHERE job_id=?',[$jobId]);if(!$pages)throw new RuntimeException('No pages to audit.');$totals=array_fill_keys(['technical','onpage','content','performance','linking'],0);$all=[];
  foreach($pages as $p){$scores=array_fill_keys(array_keys($totals),100);foreach(self::checks($p) as $i){$scores[$i['category']]-=['critical'=>25,'high'=>12,'medium'=>6,'low'=>2,'opportunity'=>0][$i['severity']];$all[]=[$p,$i];}foreach($scores as $k=>$v)$totals[$k]+=max(0,$v);}
  foreach($totals as $k=>$v)$totals[$k]=(int)round($v/count($pages));$weights=setting('score_weights',['technical'=>30,'onpage'=>30,'content'=>20,'performance'=>10,'linking'=>10]);$score=0;foreach($totals as $k=>$v)$score+=$v*($weights[$k]??0);$score=(int)round($score/max(1,array_sum($weights)));
  db()->beginTransaction();query('INSERT INTO seo_audits(website_id,job_id,score,technical,onpage,content,performance,linking) VALUES (?,?,?,?,?,?,?,?)',array_merge([$job['website_id'],$jobId,$score],array_values($totals)));$id=(int)db()->lastInsertId();
  foreach(['title','description'] as $field){$seen=[];foreach($pages as $p){$key=trim($p[$field]);if($key!=='' && isset($seen[$key]))$all[]=[$p,['code'=>'duplicate_'.$field,'title'=>'Duplicate '.$field,'severity'=>'medium','category'=>'onpage','why'=>'Identical metadata may obscure page differences.','fix'=>'Write distinct metadata for unique pages.']];$seen[$key]=true;}}
  $sitemap=json_decode($job['sitemap']??'{}',true);if(!($sitemap['valid']??false))$all[]=[$pages[0],['code'=>'sitemap','title'=>'Valid sitemap not found at /sitemap.xml','severity'=>'medium','category'=>'technical','why'=>'A sitemap helps discover URLs; other sitemap locations were not checked.','fix'=>'Publish a valid XML sitemap and declare its location in robots.txt.']];
  $all=array_merge($all,Resources::issues($job,$pages));
  $perPage=[];foreach($pages as $p)$perPage[$p['id']]=array_fill_keys(array_keys($totals),100);
  foreach($all as [$p,$i])$perPage[$p['id']][$i['category']]-=['critical'=>25,'high'=>12,'medium'=>6,'low'=>2,'opportunity'=>0][$i['severity']];
  $totals=array_fill_keys(array_keys($totals),0);foreach($perPage as $scores)foreach($scores as $k=>$v)$totals[$k]+=max(0,$v);foreach($totals as $k=>$v)$totals[$k]=(int)round($v/count($pages));$score=0;foreach($totals as $k=>$v)$score+=$v*($weights[$k]??0);$score=(int)round($score/max(1,array_sum($weights)));
  query('UPDATE seo_audits SET score=?,technical=?,onpage=?,content=?,performance=?,linking=? WHERE id=?',array_merge([$score],array_values($totals),[$id]));
  foreach($all as [$p,$i]){query('INSERT INTO seo_issues(website_id,audit_id,page_id,code,title,severity,category,explanation,recommendation,url) VALUES (?,?,?,?,?,?,?,?,?,?)',[$job['website_id'],$id,$p['id'],$i['code'],$i['title'],$i['severity'],$i['category'],$i['why'],$i['fix'],$p['url']]);$issueId=db()->lastInsertId();if(value('SELECT enabled FROM automation_rules WHERE website_id=? AND code=?',[$job['website_id'],$i['code']]))query('INSERT IGNORE INTO seo_tasks(website_id,title,url,issue_id,priority,notes) VALUES (?,?,?,?,?,?)',[$job['website_id'],$i['title'],$p['url'],$issueId,in_array($i['severity'],['critical','high','medium','low'])?$i['severity']:'low',$i['fix']]);}
  db()->commit();return $id;
 }
}
