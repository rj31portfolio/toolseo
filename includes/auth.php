<?php
function auth_token(int $uid,string $purpose,int $hours): string { $t=bin2hex(random_bytes(32)); query('INSERT INTO auth_tokens (user_id,token_hash,purpose,expires_at) VALUES (?,?,?,DATE_ADD(NOW(),INTERVAL ? HOUR))',[$uid,hash('sha256',$t),$purpose,$hours]); return $t; }
function consume_token(string $token,string $purpose): array { $t=row('SELECT * FROM auth_tokens WHERE token_hash=? AND purpose=? AND expires_at>NOW() FOR UPDATE',[hash('sha256',$token),$purpose]); if (!$t) fail('This link has expired or has already been used.'); query('DELETE FROM auth_tokens WHERE id=?',[$t['id']]); return $t; }
function email_queue(string $email,string $subject,string $body): void { query('INSERT INTO email_logs (recipient,subject,body) VALUES (?,?,?)',[$email,$subject,$body]); }
function auth_action(string $action): never {
 check_csrf(); rate_limit('auth:'.$action);
 if ($action==='logout') { audit_log('logout'); if (isset($_COOKIE['seo_remember'])) query('DELETE FROM auth_tokens WHERE token_hash=?',[hash('sha256',$_COOKIE['seo_remember'])]); setcookie('seo_remember','',['expires'=>1,'path'=>base_path()?:'/','httponly'=>true,'samesite'=>'Lax']); $_SESSION=[]; session_destroy(); redirect('/login'); }
 if ($action==='register') {
  if (!setting('registration',true)) fail('Registration is currently closed.');
  $name=required_input('name',120); $email=strtolower(required_input('email',190)); $password=required_input('password',200);
  if (!filter_var($email,FILTER_VALIDATE_EMAIL)||strlen($password)<12) fail('Use a valid email address and a password of at least 12 characters.');
  db()->beginTransaction();
  if (value('SELECT id FROM users WHERE email=?',[$email])) fail('Unable to register this email. Try signing in or resetting your password.');
  query('INSERT INTO users (name,email,password) VALUES (?,?,?)',[$name,$email,password_hash($password,PASSWORD_DEFAULT)]); $id=(int)db()->lastInsertId();
  query("INSERT INTO user_roles(user_id,role_id) SELECT ?,id FROM roles WHERE name='customer'",[$id]);
  $trialDays=max(0,min(90,(int)setting('trial_days',0)));$trialPlan=(int)setting('trial_plan_id',2);
  if($trialDays && value('SELECT id FROM plans WHERE id=? AND active=1',[$trialPlan]))query('INSERT INTO subscriptions(user_id,plan_id,starts_at,ends_at,is_trial) VALUES (?,?,NOW(),DATE_ADD(NOW(),INTERVAL ? DAY),1)',[$id,$trialPlan,$trialDays]);
  else query("INSERT INTO subscriptions(user_id,plan_id,starts_at) SELECT ?,id,NOW() FROM plans WHERE slug='free'",[$id]);
  $token=auth_token($id,'verify',48); email_queue($email,'Welcome to SEO AutoPilot — verify your email',cfg('APP_URL').'/verify-email?token='.$token);
  db()->commit(); session_regenerate_id(true); $_SESSION['user_id']=$id; $_SESSION['session_version']=1; audit_log('registered'); redirect('/dashboard');
 }
 if ($action==='login') {
  rate_limit('login-account',30,900,strtolower(input('email',190)));
  $u=row('SELECT * FROM users WHERE email=? AND active=1',[strtolower(input('email',190))]);
  $hash=$u['password']??'$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.';
  if (!password_verify(input('password',200),$hash)||!$u) { audit_log('login_failed'); fail('Email or password is incorrect.',401); }
  session_regenerate_id(true); $_SESSION['user_id']=$u['id']; $_SESSION['session_version']=(int)$u['session_version']; $_SESSION['last_seen']=time(); $_SESSION['csrf']=bin2hex(random_bytes(32));
  if (isset($_POST['remember'])) { $t=auth_token((int)$u['id'],'remember',720); setcookie('seo_remember',$t,['expires'=>time()+2592000,'path'=>base_path()?:'/','secure'=>str_starts_with(cfg('APP_URL'),'https://'),'httponly'=>true,'samesite'=>'Lax']); }
  audit_log('login'); redirect('/dashboard');
 }
 if ($action==='forgot-password') { $u=row('SELECT * FROM users WHERE email=?',[strtolower(input('email',190))]); if ($u) { $t=auth_token((int)$u['id'],'reset',1); email_queue($u['email'],'Reset your password',cfg('APP_URL').'/reset-password?token='.$t); } $_SESSION['flash']='If the address has an account, a reset link has been queued for delivery.'; redirect('/forgot-password'); }
 if ($action==='reset-password') { $p=required_input('password',200); if (strlen($p)<12) fail('Password must have at least 12 characters.'); db()->beginTransaction(); $t=consume_token(input('token',100),'reset'); query('UPDATE users SET password=?,session_version=session_version+1 WHERE id=?',[password_hash($p,PASSWORD_DEFAULT),$t['user_id']]); query('DELETE FROM auth_tokens WHERE user_id=?',[$t['user_id']]); db()->commit(); audit_log('password_reset'); $_SESSION['flash']='Password updated. Sign in with your new password.'; redirect('/login'); }
 if ($action==='verify-email') { db()->beginTransaction(); $t=consume_token(input('token',100),'verify'); query('UPDATE users SET verified_at=NOW() WHERE id=?',[$t['user_id']]); db()->commit(); $_SESSION['flash']='Email verified.'; redirect('/dashboard'); }
 fail('Unknown action.',404);
}
