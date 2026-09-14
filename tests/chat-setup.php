<?php
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
if(!str_starts_with(cfg('DB_NAME'),'seo_autopilot_test'))throw new RuntimeException('Use an isolated test database.');
LiveChat::migrate();$credentials=[];
foreach(['owner','other'] as $role){$email='chat-'.$role.'@seo-autopilot.test';$password=bin2hex(random_bytes(16));query("INSERT INTO users(name,email,password,role,active,verified_at) VALUES (?,?,?,'customer',1,NOW()) ON DUPLICATE KEY UPDATE password=VALUES(password),active=1",['Chat '.$role,$email,password_hash($password,PASSWORD_DEFAULT)]);$credentials[$role]=['email'=>$email,'password'=>$password];}
file_put_contents(ROOT.'/storage/chat-test-credentials.json',json_encode($credentials));echo "Isolated chat test accounts ready.\n";
