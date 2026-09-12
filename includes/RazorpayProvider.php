<?php
final class RazorpayProvider implements PaymentProviderInterface {
 public function createOrder(int $amount,string $currency,string $receipt): array {
  if(!cfg('RAZORPAY_KEY')||!cfg('RAZORPAY_SECRET'))fail('Payment provider not configured.',503);
  $r=SafeHttp::request('https://api.razorpay.com/v1/orders','POST',['Content-Type: application/json','Authorization: Basic '.base64_encode(cfg('RAZORPAY_KEY').':'.cfg('RAZORPAY_SECRET'))],json_encode(['amount'=>$amount,'currency'=>$currency,'receipt'=>$receipt]),0);if($r['status']!==200)fail('Payment provider could not create an order.',503);$d=json_decode($r['body'],true,32,JSON_THROW_ON_ERROR);if(empty($d['id']))fail('Invalid payment provider response.',503);return $d;
 }
 public function verifySignature(string $body,string $signature): bool {return cfg('RAZORPAY_WEBHOOK_SECRET') && hash_equals(hash_hmac('sha256',$body,cfg('RAZORPAY_WEBHOOK_SECRET')),$signature);}
}
