<?php
final class GuestDemo {
 public const TOOLS=['qr','whatsapp','chat'];
 public static function identity(): string {
  $id=$_COOKIE['zentro_demo']??($_SESSION['zentro_demo']??'');
  if(!is_string($id)||!preg_match('/^[a-f0-9]{64}$/D',$id))$id=bin2hex(random_bytes(32));
  $_SESSION['zentro_demo']=$id;
  setcookie('zentro_demo',$id,['expires'=>time()+31536000,'path'=>base_path()?:'/','secure'=>str_starts_with(cfg('APP_URL'),'https://'),'httponly'=>true,'samesite'=>'Lax']);
  return $id;
 }
 public static function quota(string $tool,bool $consume=false): array {
  if(!in_array($tool,self::TOOLS,true))fail('Unknown demo.');
  if(current_user())return ['remaining'=>null,'signed_in'=>true];
  $bucket=hash('sha256','zentro-demo|'.self::identity().'|'.$tool);
  db()->beginTransaction();
  try{
   query('INSERT IGNORE INTO rate_limits(bucket,hits,expires_at) VALUES (?,0,DATE_ADD(NOW(),INTERVAL 1 YEAR))',[$bucket]);
   $hits=(int)value('SELECT hits FROM rate_limits WHERE bucket=? FOR UPDATE',[$bucket]);
   if($consume&&$hits>=3){db()->commit();fail('You have used your 3 free tries for this tool. Log in or create a free account to continue.',401);}
   if($consume){query('UPDATE rate_limits SET hits=hits+1 WHERE bucket=?',[$bucket]);$hits++;}
   db()->commit();return ['remaining'=>max(0,3-$hits),'signed_in'=>false];
  }catch(Throwable $e){if(db()->inTransaction())db()->rollBack();throw $e;}
 }
}
