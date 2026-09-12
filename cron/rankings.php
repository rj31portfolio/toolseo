<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
if(!cfg('RANKING_ENDPOINT')||!cfg('RANKING_API_KEY')){echo "Ranking API not configured.\n";exit;}
if(time()-(int)setting('last_ranking_run',0)<max(1,(int)setting('ranking_frequency_hours',24))*3600){echo "Ranking interval not reached.\n";exit;}
if(!value("SELECT GET_LOCK('seo_ranking_worker',0)"))exit;
$failed=false;
try{
 $keywords=rows("SELECT k.*,w.domain FROM keywords k JOIN websites w ON w.id=k.website_id WHERE k.search_engine='google' AND NOT EXISTS (SELECT 1 FROM keyword_rankings r WHERE r.keyword_id=k.id AND r.date=CURDATE() AND r.source=?) ORDER BY k.id LIMIT 100",[Ranking::source()]);
 foreach($keywords as $keyword){try{Ranking::check($keyword);}catch(Throwable $e){$failed=true;fwrite(STDERR,'Keyword '.$keyword['id'].': '.$e->getMessage().PHP_EOL);break;}}
 if(!$failed&&count($keywords)<100)query('INSERT INTO settings(name,value) VALUES (?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)',['last_ranking_run',json_encode(time())]);
}finally{value("SELECT RELEASE_LOCK('seo_ranking_worker')");}
exit($failed?1:0);
