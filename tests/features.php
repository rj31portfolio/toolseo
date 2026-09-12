<?php
require dirname(__DIR__).'/includes/bootstrap.php';
require ROOT.'/includes/auth.php';
if(PHP_SAPI!=='cli'||!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test'))throw new RuntimeException('Use an isolated test database');
query('DELETE FROM rate_limits'); // Reset only the isolated suite's request budget.
$credentials=json_decode(file_get_contents(getenv('SEO_TEST_CREDENTIALS')?:ROOT.'/storage/review-credentials.json'),true);
$c=curl_init();curl_setopt_array($c,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEFILE=>'',CURLOPT_PROXY=>'',CURLOPT_TIMEOUT=>30]);$count=0;
function feature(bool $ok,string $label):void{global $count;if(!$ok)throw new RuntimeException('FAIL '.$label);$count++;echo "PASS $label\n";}
function req(string $path,?array $data=null,int $expected=200):string{global $c;curl_setopt($c,CURLOPT_URL,cfg('APP_URL').$path);if($data!==null)curl_setopt($c,CURLOPT_POSTFIELDS,$data);else curl_setopt($c,CURLOPT_HTTPGET,true);$body=curl_exec($c);if($body===false)throw new RuntimeException(curl_error($c));$status=curl_getinfo($c,CURLINFO_RESPONSE_CODE);feature($status===$expected,$path.' HTTP '.$expected.($status!==$expected?' got '.$status.' '.substr(strip_tags($body),0,200):''));return $body;}
function act(string $action,array $data=[],int $expected=200):array{global $csrf;return json_decode(req('/api/v1/'.$action,['csrf'=>$csrf]+$data,$expected),true)??[];}
preg_match('/name="csrf-token" content="([a-f0-9]+)"/',req('/login'),$m);req('/login',['csrf'=>$m[1]]+$credentials,303);
preg_match('/name="csrf-token" content="([a-f0-9]+)"/',req('/dashboard'),$m);$csrf=$m[1];
$w=row('SELECT * FROM websites ORDER BY id LIMIT 1');$wid=(int)$w['id'];$uid=(int)$w['user_id'];$scope=['website_id'=>$wid];
act('admin/subscription',['user_id'=>$uid,'plan_id'=>4,'ends_at'=>'2030-01-01']);
// Save and edit every record form, then test its delete button.
$fixtures=[
 'keywords'=>['keyword'=>'Review keyword '.bin2hex(random_bytes(3)),'country'=>'India','device'=>'desktop'],
 'competitors'=>['domain'=>'https://example.net/','notes'=>'Review competitor'],
 'backlinks'=>['source_url'=>'https://example.net/post','target_url'=>'https://example.com/','anchor'=>'Review','follow'=>'follow','status'=>'active'],
 'content'=>['topic'=>'Review content','keyword'=>'seo','audience'=>'Editors'],
 'tasks'=>['title'=>'Review task','due_date'=>'2026-12-01','priority'=>'medium','status'=>'open'],
 'human-services'=>['service'=>'Technical SEO','budget'=>'500','description'=>'Review request','priority'=>'medium']
];
foreach($fixtures as $module=>$data){$created=act('save',$scope+['module'=>$module]+$data);$id=(int)$created['data']['id'];act('save',$scope+['module'=>$module,'id'=>$id]+$data);req('/'.$module.'?website_id='.$wid.'&edit='.$id);act('delete',$scope+['module'=>$module,'id'=>$id]);}
// A reproducible crawl snapshot tests audit/report interactions without a network provider.
query("INSERT INTO crawl_jobs(website_id,max_pages,processed,status,robots,sitemap,completed_at) VALUES (?,2,2,'completed','','{}',NOW())",[$wid]);$jid=(int)db()->lastInsertId();
foreach(['https://example.com/'=>'<h1>Review home</h1><p>Technical SEO guide</p>','https://example.com/guide'=>'<h1>Technical SEO guide</h1>'] as $url=>$html){
 $p=Crawler::parse(['url'=>$url,'status'=>200,'body'=>'<html><head><title>Review</title></head><body>'.$html.'</body></html>','headers'=>[],'redirects'=>[$url],'ms'=>50],$w['domain']);$p['score']=Audit::pageScore($p);$vals=array_map(fn($v)=>is_array($v)?json_encode($v):$v,array_values($p));
 query('INSERT INTO pages(website_id,job_id,url_hash,'.implode(',',array_keys($p)).') VALUES ('.implode(',',array_fill(0,count($vals)+3,'?')).')',array_merge([$wid,$jid,hash('sha256',$url)],$vals));
}
act('audit',$scope);$issue=(int)value('SELECT id FROM seo_issues WHERE website_id=? ORDER BY id DESC LIMIT 1',[$wid]);
act('issue-task',$scope+['id'=>$issue]);act('issue-status',$scope+['id'=>$issue,'status'=>'resolved']);feature(value('SELECT status FROM seo_issues WHERE id=?',[$issue])==='resolved','Issue status persists');
act('find-links',$scope);$link=(int)value('SELECT id FROM internal_link_suggestions WHERE website_id=? ORDER BY id DESC LIMIT 1',[$wid]);feature($link>0,'Internal link opportunity generated');foreach(['accepted','rejected','implemented'] as $status)act('link-status',$scope+['id'=>$link,'status'=>$status]);
$page=(int)value('SELECT id FROM pages WHERE job_id=? LIMIT 1',[$jid]);act('save-page-suggestions',$scope+['id'=>$page,'content'=>'Reviewed metadata recommendation']);act('page-suggestions',$scope+['id'=>$page],503);
$content=(int)value('SELECT id FROM content_projects WHERE website_id=? LIMIT 1',[$wid]);act('save-brief',$scope+['id'=>$content,'content'=>'Reviewed manual content brief']);act('content-brief',$scope+['id'=>$content],503);req('/content?website_id='.$wid.'&brief='.$content);
$report=act('report',$scope);$rid=(int)value('SELECT id FROM reports WHERE website_id=? ORDER BY id DESC LIMIT 1',[$wid]);req('/report?id='.$rid);$pdf=req('/report?id='.$rid.'&pdf=1');feature(str_starts_with($pdf,'%PDF'),'Populated audit report downloads as PDF');
act('email-report',$scope+['id'=>$rid]);$notification=(int)value('SELECT id FROM notifications WHERE user_id=? ORDER BY id DESC LIMIT 1',[$uid]);act('notification-read',['id'=>$notification]);feature(value('SELECT read_at FROM notifications WHERE id=?',[$notification])!==null,'Notification read persists');req('/api/v1/notifications');
act('profile',['name'=>'Review Administrator','timezone'=>'UTC','country'=>'India','company'=>'Review company']);
$coupon='REVIEW'.bin2hex(random_bytes(4));$couponData=['code'=>$coupon,'type'=>'percentage','amount'=>'10','starts_at'=>'2026-01-01','ends_at'=>'2030-01-01','usage_limit'=>'10','per_user_limit'=>'1'];act('admin/coupon',$couponData);$cid=(int)value('SELECT id FROM coupons WHERE code=?',[$coupon]);act('admin/coupon-toggle',['id'=>$cid,'active'=>'0']);
$plan=row('SELECT * FROM plans WHERE id=2');act('admin/plan',array_map('strval',array_intersect_key($plan,array_flip(['id','name','price','websites','keywords','crawl_pages','reports','ai_requests','team_members','white_label']))));
act('admin/settings',['site_name'=>'Review workspace','contact_email'=>'review@example.test','crawl_delay_ms'=>'200','registration'=>'1','maintenance'=>'0','require_verification'=>'0','score_weights'=>'{"technical":30,"onpage":30,"content":20,"performance":10,"linking":10}']);
act('admin/page',['page'=>'about','content'=>'Reviewed about page']);feature(str_contains(req('/about'),'Reviewed about page'),'Public page editor persists');
$service=(int)act('save',$scope+['module'=>'human-services']+$fixtures['human-services'])['data']['id'];act('admin/quote',['id'=>$service,'amount'=>'50000']);act('admin/service',['id'=>$service,'assigned_user'=>$uid,'status'=>'in_progress']);
act('extra-checkout',['purpose'=>'service','service_request_id'=>$service],503);act('extra-checkout',['purpose'=>'ai_credits'],503);
$backup=req('/api/v1/admin/backup',['csrf'=>$csrf]);feature(str_contains($backup,'CREATE TABLE')&&str_contains($backup,'SET FOREIGN_KEY_CHECKS=1'),'Database export contains schema and rows');
// Validate errors from user-entered values, not only happy paths.
act('save',$scope+['module'=>'tasks','title'=>'Invalid date','due_date'=>'2026-02-31'],422);
act('admin/coupon',$couponData,422);
// Verify service and credit invoices using signed test events, with no live checkout.
$config['RAZORPAY_WEBHOOK_SECRET']='isolated-review-webhook';
$beforeCredits=(int)value('SELECT credits FROM ai_credit_balances WHERE user_id=?',[$uid]);
foreach(['ai_credits','service'] as $purpose){
 $order='review_'.bin2hex(random_bytes(8));$amount=199950;
 query('INSERT INTO payments(user_id,plan_id,amount,order_id,purpose,service_request_id,ai_credits) VALUES (?,1,?,?,?,?,?)',[$uid,$amount,$order,$purpose,$purpose==='service'?$service:null,$purpose==='ai_credits'?50:0]);
 $pid=(int)db()->lastInsertId();
 $raw=json_encode(['event'=>'payment.captured','payload'=>['payment'=>['entity'=>['id'=>'pay_'.$order,'order_id'=>$order,'amount'=>$amount,'currency'=>'INR','status'=>'captured']]]]);
 $signature=hash_hmac('sha256',$raw,$config['RAZORPAY_WEBHOOK_SECRET']);Payment::webhook($raw,$signature);Payment::webhook($raw,$signature);
 $iid=(int)value('SELECT id FROM invoices WHERE payment_id=?',[$pid]);$invoice=req('/invoice?id='.$iid);
 feature(str_contains($invoice,$purpose==='ai_credits'?'50 AI credits':'Technical SEO'),'Invoice describes '.$purpose.' purchase');
 feature(str_contains($invoice,'1,999.50'),'Invoice preserves paise');
 feature((int)value('SELECT COUNT(*) FROM invoices WHERE payment_id=?',[$pid])===1,'Duplicate '.$purpose.' webhook does not duplicate invoice');
}
feature((int)value('SELECT credits FROM ai_credit_balances WHERE user_id=?',[$uid])===$beforeCredits+50,'Credit payment is fulfilled exactly once');
$customer=(int)value("SELECT id FROM users WHERE role='customer' ORDER BY id LIMIT 1");
act('admin/user',['id'=>$customer,'role'=>'customer','active'=>'0']);feature((int)value('SELECT active FROM users WHERE id=?',[$customer])===0,'Disable account persists');act('admin/user',['id'=>$customer,'role'=>'customer','active'=>'1']);
act('admin/user',['id'=>$uid,'role'=>'customer','active'=>'0'],422);
act('admin/provider',['provider'=>'ai','clear'=>'1']);
feature(empty((require ROOT.'/storage/review-config.php')['AI_API_KEY']),'Provider clear updates isolated configuration');
$member=(int)value('SELECT id FROM team_members WHERE website_id=? AND user_id<>? LIMIT 1',[$wid,$uid]);if($member){act('team-remove',$scope+['id'=>$member]);feature(!value('SELECT id FROM team_members WHERE id=?',[$member]),'Remove team access persists');}
act('cancel-subscription');feature(plan($uid)['slug']==='free','Cancel subscription returns Free limits');
echo "PASS: $count feature checks\n";
