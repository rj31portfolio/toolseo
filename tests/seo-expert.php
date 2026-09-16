<?php
// Isolated database and HTTP server. No application enquiries are altered.
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
$name='seo_expert_test_'.bin2hex(random_bytes(5));$server=new PDO('mysql:host='.cfg('DB_HOST').';port='.cfg('DB_PORT'),cfg('DB_USER'),cfg('DB_PASS'),[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$server->exec('CREATE DATABASE `'.$name.'` CHARACTER SET utf8mb4');$config['DB_NAME']=$name;$process=null;
function expert_check(bool $ok,string $label): void {if(!$ok)throw new RuntimeException($label);echo 'PASS '.$label."\n";}
try {
 foreach([ROOT.'/database/database.sql',...glob(ROOT.'/database/migrations/*.sql')] as $file)foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents($file)) as $sql)if(trim($sql)!=='')query($sql);
 SeoExpert::migrate();expert_check(SeoExpert::ready(),'Migration can rerun safely');
 foreach(SeoExpert::prices() as $months=>$plans)foreach($plans as $plan=>$price)expert_check(SeoExpert::price($plan,$months)===$price*100,'Price '.$plan.' '.$months);
 expert_check(SeoExpert::savings('starter',12)['total']==399700,'Annual savings compared to four quarterly programs');
 expert_check(SeoExpert::endDate('2026-01-31',3)==='2026-04-29','Month-end program dates');
 expert_check(SeoExpert::csvCell('=HYPERLINK("x")')[0]==="'",'CSV formula neutralization');
 $password=bin2hex(random_bytes(16));query("INSERT INTO users(name,email,password,role,verified_at) VALUES ('Test Admin','expert-admin@example.test',?,'super_admin',NOW())",[password_hash($password,PASSWORD_DEFAULT)]);
 $env=getenv();foreach(['DB_HOST','DB_PORT','DB_USER','DB_PASS'] as $key)$env[$key]=(string)cfg($key);$env['DB_NAME']=$name;$env['APP_URL']='http://127.0.0.1:8139';$env['EXPERT_TEST_PASSWORD']=$password;$env['EXPERT_TEST_URL']=$env['APP_URL'];
 $process=proc_open([PHP_BINARY,'-S','127.0.0.1:8139','tests/router.php'],[0=>['pipe','r'],1=>['file',ROOT.'/storage/logs/seo-expert-test.log','a'],2=>['file',ROOT.'/storage/logs/seo-expert-test.log','a']],$pipes,ROOT,$env);
 if(!is_resource($process))throw new RuntimeException('Could not start isolated server');
 $browser=proc_open(['node','tests/seo-expert-browser.cjs'],[0=>['pipe','r'],1=>STDOUT,2=>STDERR],$browserPipes,ROOT,$env);$code=proc_close($browser);expert_check($code===0,'Browser workflow');
 expert_check((int)value('SELECT COUNT(*) FROM seo_expert_enquiries')===1,'Enquiry persisted once');
 expert_check((int)value('SELECT COUNT(*) FROM seo_expert_clients')===1,'Client profile persisted');
 expert_check((int)value("SELECT amount FROM seo_expert_payments WHERE status='paid'")===1499900,'Payment saved in paise');
} finally {if(is_resource($process))proc_terminate($process);$server->exec('DROP DATABASE `'.$name.'`');}

