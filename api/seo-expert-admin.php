<?php
header('Cache-Control: no-store');$user=require_admin();
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Use POST.',405);check_csrf();rate_limit('seo-expert-admin:'.$user['id'],100,60);
if(!SeoExpert::ready())fail('Run cron/migrate-seo-expert.php to install the service.',503);
$operation=enum_input('operation',['update','note','payment','payment_status','client','task','task_status','ranking','report','export']);
if($operation==='export')SeoExpertManagement::export($_POST);
$id=SeoExpertManagement::id();$clientOperation=in_array($operation,['client','task','task_status','ranking','report']);
db()->beginTransaction();
try {
 if($operation==='update')SeoExpertManagement::update($id);
 elseif($operation==='note'){SeoExpert::enquiry($id,true);query('INSERT INTO seo_expert_notes(enquiry_id,author_id,body) VALUES (?,?,?)',[$id,$user['id'],required_input('body',10000)]);}
 elseif($operation==='payment')SeoExpertManagement::payment($id,(int)$user['id']);
 elseif($operation==='payment_status'){
  SeoExpert::enquiry($id,true);$paymentId=SeoExpertManagement::id('payment_id');$payment=row('SELECT * FROM seo_expert_payments WHERE id=? AND enquiry_id=?',[$paymentId,$id]);if(!$payment)fail('Payment not found.',404);
  if($payment['status']!=='pending')fail('Only pending entries can change status. Record a refund to reverse a received payment.');
  query('UPDATE seo_expert_payments SET status=? WHERE id=?',[enum_input('payment_state',['paid','failed','cancelled']),$paymentId]);SeoExpert::syncPayment($id);audit_log('seo_expert.payment.status',['id'=>$paymentId]);
 }elseif($operation==='client')SeoExpertManagement::clientUpdate($id);
 else SeoExpertManagement::clientEntry($operation,$id);
 db()->commit();
}catch(Throwable $e){db()->rollBack();if($e instanceof InvalidArgumentException)fail($e->getMessage());throw $e;}
$_SESSION['flash']='SEO Expert record saved.';json_response(['redirect'=>url('/admin/seo-expert?'.($clientOperation?'client=':'id=').$id)],'SEO Expert record saved.');
