<?php
if(PHP_SAPI!=='cli')exit;
$root=dirname(__DIR__);
$config=require $root.'/config/config.php';
$pdo=new PDO('mysql:host='.$config['DB_HOST'].';port='.$config['DB_PORT'],$config['DB_USER'],$config['DB_PASS'],[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$config['DB_NAME']='seo_autopilot_test_review_'.date('YmdHis');
$config['APP_URL']='http://127.0.0.1:8086';
foreach(['SMTP_HOST','SMTP_USER','SMTP_PASS','SMTP_FROM','AI_ENDPOINT','AI_API_KEY','RANKING_ENDPOINT','RANKING_API_KEY','KEYWORD_ENDPOINT','KEYWORD_API_KEY','BACKLINK_ENDPOINT','BACKLINK_API_KEY','RAZORPAY_KEY','RAZORPAY_SECRET','RAZORPAY_WEBHOOK_SECRET'] as $key)$config[$key]='';
$pdo->exec('CREATE DATABASE `'.$config['DB_NAME'].'` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
$pdo->exec('USE `'.$config['DB_NAME'].'`');
foreach(array_merge([$root.'/database/database.sql'],glob($root.'/database/migrations/*.sql')) as $file){
 foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents($file)) as $sql)if(trim($sql)!=='')$pdo->exec($sql);
}
foreach(['002','003','004','005'] as $version)$pdo->exec("INSERT INTO settings(name,value) VALUES ('migration_$version','true')");
$credentials=['email'=>'review@example.test','password'=>bin2hex(random_bytes(20))];
$s=$pdo->prepare("INSERT INTO users(name,email,password,role,verified_at) VALUES ('Review Administrator',?,?,'super_admin',NOW())");
$s->execute([$credentials['email'],password_hash($credentials['password'],PASSWORD_DEFAULT)]);
$id=(int)$pdo->lastInsertId();$pdo->exec("INSERT INTO user_roles(user_id,role_id) SELECT $id,id FROM roles WHERE name='super_admin'");
file_put_contents($root.'/storage/review-config.php',"<?php\nreturn ".var_export($config,true).";\n");
file_put_contents($root.'/storage/review-credentials.json',json_encode($credentials));
echo 'Prepared isolated review database: '.$config['DB_NAME'].PHP_EOL;
