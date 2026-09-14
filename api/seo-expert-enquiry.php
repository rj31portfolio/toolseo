<?php
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Method not allowed.',405);
check_csrf();if(!SeoExpert::ready())fail('Enquiries are temporarily unavailable. Please try again shortly.',503);
rate_limit('seo-expert-enquiry',10,3600);
try{$fields=SeoExpert::fields($_POST);}catch(InvalidArgumentException $e){fail($e->getMessage());}
$type=enum_input('request_type',['audit','hire','plan'],'hire');$token=required_input('request_token',32);if(!preg_match('/^[a-f0-9]{32}$/D',$token))fail('Refresh the form and try again.');$key=hash('sha256',csrf().'|'.$token);
db()->beginTransaction();query('INSERT INTO seo_expert_enquiries(reference,request_key,request_type,full_name,business_name,website,phone,email,target_location,target_keywords,plan,duration,listed_amount,current_problem,message) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id)',[strtoupper(bin2hex(random_bytes(6))),$key,$type,$fields['full_name'],$fields['business_name'],$fields['website'],$fields['phone'],$fields['email'],$fields['target_location'],$fields['target_keywords'],$fields['plan'],$fields['duration'],$fields['listed_amount'],$fields['current_problem'],$fields['message']]);$saved=row('SELECT reference FROM seo_expert_enquiries WHERE request_key=?',[$key]);db()->commit();
header('Cache-Control: no-store');
if(str_contains($_SERVER['HTTP_ACCEPT']??'','application/json'))json_response(['reference'=>$saved['reference']],'Your enquiry has been received. Our team can now review your website and contact you.');
$_SESSION['seo_expert_confirmation']=$saved['reference'];redirect('/hire-seo-expert?submitted=1#expert-enquiry');
