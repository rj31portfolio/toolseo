<?php
require dirname(__DIR__).'/includes/bootstrap.php';
if(!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test_review_'))exit(1);
$live=require ROOT.'/config/local.php';$path=ROOT.'/storage/review-config.php';$review=require $path;
$review['RANKING_ENDPOINT']=$live['RANKING_ENDPOINT'];$review['RANKING_API_KEY']=$live['RANKING_API_KEY'];
file_put_contents($path,"<?php\nreturn ".var_export($review,true).";\n");
query("INSERT INTO websites(user_id,name,domain,domain_hash,country,language,search_engine,timezone) VALUES (1,'Google ranking demo','https://en.wikipedia.org/',?,'United States','en','google','UTC')",[hash('sha256','ranking-demo-'.random_bytes(8))]);$wid=(int)db()->lastInsertId();
query("INSERT INTO keywords(website_id,keyword,country,language,device,search_engine,target_url) VALUES (?,'Coffee','United States','en','desktop','google','')",[$wid]);$kid=(int)db()->lastInsertId();
file_put_contents(ROOT.'/storage/test-ranking-fixture.json',json_encode(['website_id'=>$wid,'keyword_id'=>$kid]));
echo "Isolated live ranking fixture ready.\n";
