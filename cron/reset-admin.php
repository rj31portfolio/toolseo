<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
$email=getenv('ADMIN_EMAIL');$password=getenv('ADMIN_PASSWORD');if(!filter_var($email,FILTER_VALIDATE_EMAIL)||strlen($password?:'')<12)throw new RuntimeException('Set ADMIN_EMAIL and ADMIN_PASSWORD (12+ characters) in your shell environment.');
$u=row("SELECT id FROM users WHERE email=? AND role='super_admin'",[$email]);if(!$u)throw new RuntimeException('Administrator not found.');query('UPDATE users SET password=?,session_version=session_version+1 WHERE id=?',[password_hash($password,PASSWORD_DEFAULT),$u['id']]);query('DELETE FROM auth_tokens WHERE user_id=?',[$u['id']]);echo "Administrator password reset and previous sessions revoked.\n";
