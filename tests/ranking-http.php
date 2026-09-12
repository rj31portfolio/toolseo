<?php
require dirname(__DIR__).'/includes/bootstrap.php';
if(PHP_SAPI!=='cli'||!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test_review_'))throw new RuntimeException('Use the isolated review database.');
$credentials=json_decode(file_get_contents(ROOT.'/storage/review-credentials.json'),true);
$fixture=json_decode(file_get_contents(ROOT.'/storage/test-ranking-fixture.json'),true);
$c=curl_init();curl_setopt_array($c,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEFILE=>'',CURLOPT_PROXY=>'',CURLOPT_TIMEOUT=>10]);
function request_rank(string $path,?array $data=null):array{global $c;curl_setopt($c,CURLOPT_URL,cfg('APP_URL').$path);if($data!==null)curl_setopt($c,CURLOPT_POSTFIELDS,$data);else curl_setopt($c,CURLOPT_HTTPGET,true);$body=curl_exec($c);return [(int)curl_getinfo($c,CURLINFO_RESPONSE_CODE),$body];}
function verify_rank(bool $ok,string $label):void{if(!$ok)throw new RuntimeException('FAIL '.$label);echo 'PASS '.$label.PHP_EOL;}
preg_match('/name="csrf-token" content="([a-f0-9]+)"/',request_rank('/login')[1],$m);
verify_rank(request_rank('/login',['csrf'=>$m[1]]+$credentials)[0]===303,'Ranking test login');
preg_match('/name="csrf-token" content="([a-f0-9]+)"/',request_rank('/dashboard')[1],$m);$csrf=$m[1];
verify_rank(request_rank('/api/v1/ranking-check',$fixture)[0]===419,'Ranking API requires CSRF');
verify_rank(request_rank('/api/v1/ranking-check',['csrf'=>$csrf,'website_id'=>1,'keyword_id'=>$fixture['keyword_id']])[0]===404,'Keyword must belong to selected project');
[$status,$body]=request_rank('/api/v1/ranking-check',['csrf'=>$csrf]+$fixture);
verify_rank($status===200&&json_decode($body,true)['data']['position']===1,'Daily cached ranking returned without another search');
verify_rank((int)value('SELECT COUNT(*) FROM keyword_rankings WHERE keyword_id=? AND date=CURDATE()',[$fixture['keyword_id']])===1,'Repeated checks do not duplicate daily history');
query("INSERT INTO keywords(website_id,keyword,country,language,device,search_engine,target_url) VALUES (?,'Invalid audience fixture','Unknown country','en','desktop','google','')",[$fixture['website_id']]);$kid=(int)db()->lastInsertId();
try{
 query("INSERT INTO keyword_rankings(keyword_id,date,position,url,source) VALUES (?,DATE_SUB(CURDATE(),INTERVAL 1 DAY),5,'https://en.wikipedia.org/wiki/Coffee','api')",[$kid]);
 [$status,$body]=request_rank('/api/v1/ranking-check',['csrf'=>$csrf,'website_id'=>$fixture['website_id'],'keyword_id'=>$kid]);
 verify_rank($status===503&&str_contains($body,'country code'),'Invalid audience produces actionable feedback');
 verify_rank((int)value('SELECT position FROM keyword_rankings WHERE keyword_id=?',[$kid])===5,'Failed check preserves previous position');
 verify_rank((int)value('SELECT COUNT(*) FROM keyword_rankings WHERE keyword_id=? AND date=CURDATE()',[$kid])===0,'Failed check never records a false missing ranking');
}finally{query('DELETE FROM keywords WHERE id=?',[$kid]);}
verify_rank(!str_contains(request_rank('/rankings?website_id='.$fixture['website_id'])[1],cfg('RANKING_API_KEY')),'API key is absent from rendered ranking page');
