<?php
final class Mailer {
 public static function work(): void {
  if(!value("SELECT GET_LOCK('seo_mail_worker',0)"))return;
  try{if(!cfg('SMTP_HOST')||!cfg('SMTP_FROM')){query("UPDATE email_logs SET status='failed',error='SMTP not configured' WHERE status='queued'");return;}if(!is_file(ROOT.'/vendor/autoload.php'))throw new RuntimeException('Run composer install to enable SMTP.');require_once ROOT.'/vendor/autoload.php';
   $messages=rows("SELECT * FROM email_logs WHERE (status='queued' OR (status='failed' AND attempts<3)) ORDER BY id LIMIT 20");foreach($messages as $message){query("UPDATE email_logs SET status='sending',attempts=attempts+1 WHERE id=?",[$message['id']]);try{$m=new PHPMailer\PHPMailer\PHPMailer(true);$m->isSMTP();$m->Host=cfg('SMTP_HOST');$m->Port=(int)cfg('SMTP_PORT');$m->SMTPAuth=cfg('SMTP_USER')!=='';$m->Username=cfg('SMTP_USER');$m->Password=cfg('SMTP_PASS');$m->SMTPSecure=(int)cfg('SMTP_PORT')===465?'ssl':'tls';$m->Timeout=15;$m->CharSet='UTF-8';$m->setFrom(cfg('SMTP_FROM'),cfg('APP_NAME'));$m->addAddress($message['recipient']);$m->Subject=$message['subject'];$m->Body=$message['body'];$m->send();query("UPDATE email_logs SET status='sent',sent_at=NOW(),error=NULL,body='' WHERE id=?",[$message['id']]);}catch(Throwable $e){query("UPDATE email_logs SET status='failed',error='SMTP delivery failed; check server configuration' WHERE id=?",[$message['id']]);error_log((string)$e);}}
  }finally{value("SELECT RELEASE_LOCK('seo_mail_worker')");}
 }
}
