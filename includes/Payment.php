<?php
final class Payment {
 public static function checkout(array $user): never {
  if(!cfg('RAZORPAY_KEY')||!cfg('RAZORPAY_SECRET')||!cfg('RAZORPAY_WEBHOOK_SECRET'))fail('Payment provider not configured.',503);
  $p=row('SELECT * FROM plans WHERE id=? AND active=1',[(int)($_POST['plan_id']??0)]);if(!$p || $p['price']<=0)fail('Choose a paid plan.');$amount=(int)$p['price'];$coupon=null;
  db()->beginTransaction();query('SELECT id FROM users WHERE id=? FOR UPDATE',[$user['id']]);
  if(input('coupon',60)!==''){$coupon=row('SELECT * FROM coupons WHERE code=? AND active=1 AND starts_at<=NOW() AND ends_at>NOW() FOR UPDATE',[strtoupper(input('coupon',60))]);if(!$coupon)fail('Coupon is invalid or expired.');$used=(int)value("SELECT COUNT(*) FROM payments WHERE coupon_id=? AND (status='paid' OR status='pending')",[$coupon['id']]);$own=(int)value("SELECT COUNT(*) FROM payments WHERE coupon_id=? AND user_id=? AND (status='paid' OR status='pending')",[$coupon['id'],$user['id']]);if($used>=$coupon['usage_limit']||$own>=$coupon['per_user_limit'])fail('Coupon usage limit reached.');$amount=max(100,$amount-($coupon['type']==='percentage'?(int)round($amount*min(100,$coupon['amount'])/100):$coupon['amount']));}
  query('INSERT INTO payments(user_id,plan_id,amount,coupon_id) VALUES (?,?,?,?)',[$user['id'],$p['id'],$amount,$coupon['id']??null]);$id=(int)db()->lastInsertId();db()->commit();
  try{$order=(new RazorpayProvider())->createOrder($amount,'INR','seo_'.$id);query('UPDATE payments SET order_id=? WHERE id=?',[$order['id'],$id]);json_response(['key'=>cfg('RAZORPAY_KEY'),'order_id'=>$order['id'],'amount'=>$amount,'currency'=>'INR','name'=>cfg('APP_NAME')],'Order created');}catch(Throwable $e){query("UPDATE payments SET status='failed' WHERE id=?",[$id]);throw $e;}
 }
 public static function webhook(string $raw,string $signature): void {
  if(!(new RazorpayProvider())->verifySignature($raw,$signature))fail('Invalid webhook signature.',401);
  try{$event=json_decode($raw,true,64,JSON_THROW_ON_ERROR);}catch(Throwable){fail('Invalid webhook JSON.');}if(($event['event']??'')!=='payment.captured')return;$entity=$event['payload']['payment']['entity']??[];
  if(($entity['status']??'')!=='captured'||empty($entity['id'])||empty($entity['order_id']))fail('Invalid captured payment.');
  db()->beginTransaction();$payment=row('SELECT * FROM payments WHERE order_id=? FOR UPDATE',[$entity['order_id']]);if(!$payment){db()->rollBack();fail('Order not found.',404);}if($payment['status']==='paid'){db()->commit();return;}
  if((int)($entity['amount']??0)!==(int)$payment['amount']||($entity['currency']??'')!==$payment['currency']){db()->rollBack();fail('Payment amount or currency mismatch.');}
  query('SELECT id FROM users WHERE id=? FOR UPDATE',[$payment['user_id']]);
  query("UPDATE payments SET status='paid',provider_payment_id=?,paid_at=NOW() WHERE id=?",[$entity['id'],$payment['id']]);
  if($payment['purpose']==='subscription'){
  $current=row("SELECT * FROM subscriptions WHERE user_id=? AND status='active' AND plan_id=? AND is_trial=0 AND ends_at>NOW() ORDER BY id DESC LIMIT 1",[$payment['user_id'],$payment['plan_id']]);
  query("UPDATE subscriptions SET status='expired' WHERE user_id=? AND status='active'",[$payment['user_id']]);
  $start=$current['ends_at']??date('Y-m-d H:i:s');$end=(new DateTimeImmutable($start))->modify('+1 month')->format('Y-m-d H:i:s');
  query('INSERT INTO subscriptions(user_id,plan_id,starts_at,ends_at) VALUES (?,?,NOW(),?)',[$payment['user_id'],$payment['plan_id'],$end]);
  }else ExtrasCheckout::fulfill($payment);
  query('INSERT INTO invoices(payment_id,number) VALUES (?,?)',[$payment['id'],'SEO-'.date('Y').'-'.str_pad((string)$payment['id'],7,'0',STR_PAD_LEFT)]);
  if($payment['coupon_id'])query('INSERT IGNORE INTO coupon_usage(coupon_id,user_id,payment_id) VALUES (?,?,?)',[$payment['coupon_id'],$payment['user_id'],$payment['id']]);notify((int)$payment['user_id'],'Payment received. Your purchase is ready.','/billing');$u=row('SELECT email FROM users WHERE id=?',[$payment['user_id']]);email_queue($u['email'],'Payment confirmed','Your payment was received and your purchase has been fulfilled. View your invoice at '.cfg('APP_URL').'/billing');audit_log('payment.captured',['payment_id'=>$payment['id']]);db()->commit();
 }
}
