<?php
final class ExtrasCheckout {
 public static function create(array $user): never {
  if(!cfg('RAZORPAY_KEY')||!cfg('RAZORPAY_SECRET')||!cfg('RAZORPAY_WEBHOOK_SECRET'))fail('Payment provider not configured.',503);
  $purpose=enum_input('purpose',['service','ai_credits']);$service=null;$credits=0;
  db()->beginTransaction();query('SELECT id FROM users WHERE id=? FOR UPDATE',[$user['id']]);
  if($purpose==='service'){$service=row('SELECT * FROM human_service_requests WHERE id=? AND user_id=? FOR UPDATE',[(int)($_POST['service_request_id']??0),$user['id']]);if(!$service||!$service['quoted_amount'])fail('An administrator must provide a quote before checkout.');if(value("SELECT id FROM payments WHERE service_request_id=? AND status IN ('paid','pending')",[$service['id']]))fail('This service already has a paid or pending order. Contact billing support to reconcile it.');$amount=(int)$service['quoted_amount'];}
  else{$amount=(int)setting('ai_pack_price',49900);$credits=(int)setting('ai_pack_credits',100);if($amount<100||$credits<1)fail('AI credit sales are not configured.');}
  $free=(int)value("SELECT id FROM plans WHERE slug='free'");query('INSERT INTO payments(user_id,plan_id,amount,purpose,service_request_id,ai_credits) VALUES (?,?,?,?,?,?)',[$user['id'],$free,$amount,$purpose,$service['id']??null,$credits]);$id=(int)db()->lastInsertId();db()->commit();
  try{$order=(new RazorpayProvider())->createOrder($amount,'INR','seo_'.$id);query('UPDATE payments SET order_id=? WHERE id=?',[$order['id'],$id]);json_response(['key'=>cfg('RAZORPAY_KEY'),'order_id'=>$order['id'],'amount'=>$amount,'currency'=>'INR','name'=>cfg('APP_NAME')],'Order created');}catch(Throwable $e){query("UPDATE payments SET status='failed' WHERE id=?",[$id]);throw $e;}
 }
 public static function fulfill(array $payment): void {
  if($payment['purpose']==='ai_credits')query('INSERT INTO ai_credit_balances(user_id,credits) VALUES (?,?) ON DUPLICATE KEY UPDATE credits=credits+VALUES(credits)',[$payment['user_id'],$payment['ai_credits']]);
  elseif($payment['purpose']==='service')query("UPDATE human_service_requests SET status=IF(assigned_user IS NULL,'new','assigned') WHERE id=? AND status IN ('new','waiting_for_customer')",[$payment['service_request_id']]);
 }
}
