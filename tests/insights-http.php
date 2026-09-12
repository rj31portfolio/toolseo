<?php
require dirname(__DIR__).'/includes/bootstrap.php';
if(PHP_SAPI!=='cli'||!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test_review_'))throw new RuntimeException('Use isolated review configuration.');
$creds=json_decode(file_get_contents(ROOT.'/storage/review-credentials.json'),true);$c=curl_init();curl_setopt_array($c,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEFILE=>'',CURLOPT_PROXY=>'',CURLOPT_TIMEOUT=>120]);$count=0;
function request_insight(string $path,?array $data=null):array{global $c;curl_setopt($c,CURLOPT_URL,cfg('APP_URL').$path);if($data!==null)curl_setopt($c,CURLOPT_POSTFIELDS,$data);else curl_setopt($c,CURLOPT_HTTPGET,true);$body=curl_exec($c);return [(int)curl_getinfo($c,CURLINFO_RESPONSE_CODE),$body];}
function assert_insight(bool $ok,string $name):void{global $count;if(!$ok)throw new RuntimeException('FAIL '.$name);$count++;echo 'PASS '.$name.PHP_EOL;}
function action_insight(string $action,array $data=[],int $status=200):array{global $csrf;[$actual,$body]=request_insight('/api/v1/'.$action,['csrf'=>$csrf]+$data);assert_insight($actual===$status,$action.' HTTP '.$status);return json_decode($body,true)??[];}
preg_match('/name="csrf-token" content="([a-f0-9]+)"/',request_insight('/login')[1],$m);request_insight('/login',['csrf'=>$m[1]]+$creds);preg_match('/name="csrf-token" content="([a-f0-9]+)"/',request_insight('/dashboard')[1],$m);$csrf=$m[1];
$w=row('SELECT * FROM websites WHERE id=1');$scope=['website_id'=>1];
action_insight('admin/subscription',['user_id'=>$w['user_id'],'plan_id'=>4,'ends_at'=>'2030-01-01']);
$seed='Insight fixture '.bin2hex(random_bytes(3));$research=['key'=>hash('sha256',json_encode([$seed,$w['country'],$w['language']])),'seed'=>$seed,'country'=>$w['country'],'language'=>$w['language'],'date'=>date('Y-m-d'),'checked_at'=>date('Y-m-d H:i:s'),'source'=>'Keyword provider','corrected'=>'','ideas'=>[['keyword'=>$seed,'type'=>'Provider suggestion','search_volume'=>250,'difficulty'=>32,'cpc'=>4.5]],'organic'=>[['position'=>1,'title'=>'Fixture <script>','url'=>'https://example.com/','snippet'=>'Research snippet']]];
Serp::save(1,'keyword_research',$research);
action_insight('research',$scope+['seed'=>$seed]);action_insight('research-add',$scope+['index'=>0]);action_insight('research-add',$scope+['index'=>0]);
$k=row('SELECT * FROM keywords WHERE website_id=1 AND keyword=?',[$seed]);assert_insight((int)$k['search_volume']===250&&(float)$k['difficulty']===32.0,'Research metrics persist on tracked keyword');assert_insight((int)value('SELECT COUNT(*) FROM keywords WHERE website_id=1 AND keyword=?',[$seed])===1,'Repeated track action does not duplicate keyword');
action_insight('research-add',$scope+['index'=>999],422);
assert_insight(str_contains(request_insight('/research?website_id=1')[1],'Fixture &lt;script&gt;'),'Research display escapes result titles');
$link=action_insight('save',$scope+['module'=>'backlinks','source_url'=>'https://example.com/','target_url'=>'https://iana.org/domains/example','anchor'=>'Old anchor','follow'=>'follow','status'=>'active']);$id=$link['data']['id'];
$result=action_insight('backlink-check',$scope+['id'=>$id]);assert_insight($result['data']['state']==='verified','Live source HTML backlink verified');assert_insight(Serp::saved(1,'backlink_check_'.$id)['state']==='verified','Verification persisted');
action_insight('save',$scope+['module'=>'backlinks','id'=>$id,'source_url'=>'http://127.0.0.1/','target_url'=>'https://iana.org/domains/example','anchor'=>'Keep anchor','follow'=>'follow','status'=>'active']);
assert_insight(!Serp::saved(1,'backlink_check_'.$id),'Editing a backlink invalidates prior verification');
$result=action_insight('backlink-check',$scope+['id'=>$id]);assert_insight($result['data']['state']==='unverified','Private network source is blocked');assert_insight(value('SELECT status FROM backlinks WHERE id=?',[$id])==='active','Failed verification preserves prior status');
action_insight('backlink-check',$scope+['id'=>999999],404);
assert_insight(request_insight('/api/v1/backlink-check',$scope+['id'=>$id])[0]===419,'Backlink checking requires CSRF');
query("INSERT INTO keyword_rankings(keyword_id,date,position,url,source) VALUES (?,CURDATE(),26,'https://example.com/','hasdata_top100')",[$k['id']]);
action_insight('report',$scope);$report=row('SELECT * FROM reports WHERE website_id=1 ORDER BY id DESC LIMIT 1');$snapshot=json_decode($report['snapshot'],true);
assert_insight(isset($snapshot['keyword_summary'],$snapshot['page_summary'],$snapshot['research']),'Performance snapshot includes analysis, page coverage and research');
$matching=array_values(array_filter($snapshot['keywords'],fn($r)=>$r['id']===$k['id']));assert_insight($matching[0]['position']===26&&$matching[0]['ranking_source']==='hasdata_top100','Report keeps true ranking source and position');
$body=request_insight('/report?id='.$report['id'])[1];assert_insight(str_contains($body,'#26')&&str_contains($body,'Backlinks &amp; verification')===false&&str_contains($body,'Backlinks & verification'),'Report includes numeric positions and backlink section');
$pdf=request_insight('/report?id='.$report['id'].'&pdf=1')[1];assert_insight(str_starts_with($pdf,'%PDF'),'Performance PDF downloads');
query('UPDATE keywords SET keyword=? WHERE id=?',[$seed.' changed',$k['id']]);assert_insight(value('SELECT snapshot FROM reports WHERE id=?',[$report['id']])===$report['snapshot'],'Saved report remains immutable');
assert_insight(str_contains(request_insight('/reports?website_id=1&preview=1')[1],$seed.' changed'),'Live report preview uses current data');
echo "PASS: $count insight workflow checks\n";
