<?php
require dirname(__DIR__).'/includes/bootstrap.php';
if(!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test_review_'))exit(1);
query("INSERT INTO websites(user_id,name,domain,domain_hash,country,language,search_engine,timezone) VALUES (1,'Ranking display regression','https://viraladsmedia.com/',?,'India','en','google','UTC')",[hash('sha256','position-regression-'.random_bytes(8))]);$wid=(int)db()->lastInsertId();
foreach([['Found on page three',26,'hasdata_top100'],['Missing after deeper search',null,'hasdata_top100'],['Old first-page check',null,'api'],['Never checked',null,null]] as [$text,$position,$source]){
query("INSERT INTO keywords(website_id,keyword,country,language,device,search_engine,target_url) VALUES (?,?,'India','en','desktop','google','https://viraladsmedia.com/')",[$wid,$text]);$kid=(int)db()->lastInsertId();
if($source)query('INSERT INTO keyword_rankings(keyword_id,date,position,url,source) VALUES (?,CURDATE(),?,?,?)',[$kid,$position,$position?'https://www.viraladsmedia.com/':'',$source]);
}
file_put_contents(ROOT.'/storage/test-position-display.json',json_encode(['website_id'=>$wid]));
echo "Display regression fixture prepared.\n";
$path=ROOT.'/storage/review-config.php';$c=require $path;$c['RANKING_ENDPOINT']='https://api.hasdata.com/scrape/google/serp';$c['RANKING_API_KEY']='test-no-network';file_put_contents($path,"<?php\nreturn ".var_export($c,true).";\n");
