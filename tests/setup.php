<?php
if(PHP_SAPI!=='cli')exit;
$root=dirname(__DIR__);
if(is_file($root.'/config/local.php')){fwrite(STDERR,"Configuration already exists; refusing to overwrite.\n");exit(1);}
$pdo=new PDO('mysql:host=127.0.0.1;port=3307;charset=utf8mb4','root','',[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$pdo->exec('CREATE DATABASE IF NOT EXISTS seo_autopilot_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci');
$config=['DB_HOST'=>'127.0.0.1','DB_PORT'=>'3307','DB_NAME'=>'seo_autopilot_test','DB_USER'=>'root','DB_PASS'=>'','APP_URL'=>'http://127.0.0.1:8085','APP_ENV'=>'development','INSTALL_TOKEN'=>bin2hex(random_bytes(32))];
file_put_contents($root.'/config/local.php',"<?php\nreturn ".var_export($config,true).";\n");
file_put_contents($root.'/storage/test-credentials.json',json_encode(['email'=>'admin@seo-autopilot.test','password'=>bin2hex(random_bytes(16))]));
echo "Isolated test database and local configuration prepared.\n";
