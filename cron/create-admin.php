<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
$email=getenv('ADMIN_EMAIL');$password=getenv('ADMIN_PASSWORD');$name=getenv('ADMIN_NAME')?:'Administrator';
if(!filter_var($email,FILTER_VALIDATE_EMAIL)||strlen($password?:'')<12)throw new RuntimeException('Set ADMIN_EMAIL and ADMIN_PASSWORD (12+ characters) in your shell environment.');
if(value('SELECT id FROM users WHERE email=?',[$email]))throw new RuntimeException('An account with this email already exists.');
db()->beginTransaction();query("INSERT INTO users(name,email,password,role,verified_at) VALUES (?,?,?,'super_admin',NOW())",[$name,$email,password_hash($password,PASSWORD_DEFAULT)]);$id=(int)db()->lastInsertId();query("INSERT INTO user_roles(user_id,role_id) SELECT ?,id FROM roles WHERE name='super_admin'",[$id]);db()->commit();echo "Administrator created. No default password is shipped.\n";
