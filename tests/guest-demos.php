<?php
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
$c=curl_init();curl_setopt_array($c,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEFILE=>'',CURLOPT_FOLLOWLOCATION=>false,CURLOPT_PROXY=>'',CURLOPT_TIMEOUT=>20]);$checks=0;$uid=null;$identity=null;
function checkDemo(bool $ok,string $name):void{global $checks;if(!$ok)throw new RuntimeException($name);echo 'PASS '.$name.PHP_EOL;$checks++;}
function demoRequest(string $path,?array $data=null,int $status=200):string{global $c;curl_setopt($c,CURLOPT_URL,rtrim(cfg('APP_URL'),'/').$path);if($data===null)curl_setopt($c,CURLOPT_HTTPGET,true);else curl_setopt_array($c,[CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>$data]);$body=curl_exec($c);checkDemo($body!==false&&curl_getinfo($c,CURLINFO_RESPONSE_CODE)===$status,$path.' '.$status);return (string)$body;}
try{
 $home=demoRequest('/');foreach(['id="qr-form"','id="whatsapp-form"','id="chat-working-demo"','id="hire-seo-expert"'] as $marker)checkDemo(str_contains($home,$marker),'Homepage includes '.$marker);
 preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$home,$m);$csrf=$m[1];
 demoRequest('/api/v1/guest-demo',null,405);demoRequest('/api/v1/guest-demo',['tool'=>'qr','operation'=>'use'],419);
 demoRequest('/api/v1/guest-demo',['csrf'=>$csrf,'tool'=>'unknown','operation'=>'use'],422);
 foreach(GuestDemo::TOOLS as $tool){
  $data=['csrf'=>$csrf,'tool'=>$tool,'operation'=>'status'];$r=json_decode(demoRequest('/api/v1/guest-demo',$data),true);checkDemo($r['data']['remaining']===3,$tool.' starts with three tries');
  foreach(curl_getinfo($c,CURLINFO_COOKIELIST) as $line){$parts=explode("\t",$line);if(($parts[5]??'')==='zentro_demo')$identity=$parts[6];}
  $data['operation']='use';for($i=2;$i>=0;$i--){$r=json_decode(demoRequest('/api/v1/guest-demo',$data),true);checkDemo($r['data']['remaining']===$i,$tool.' decrements to '.$i);}
  demoRequest('/');demoRequest('/api/v1/guest-demo',$data,401);
  $data['operation']='status';$r=json_decode(demoRequest('/api/v1/guest-demo',$data),true);checkDemo($r['data']['remaining']===0,$tool.' stays exhausted after reload');
 }
 // A new PHP session still sees the durable browser allowance.
 curl_setopt($c,CURLOPT_COOKIELIST,'ALL');curl_setopt($c,CURLOPT_COOKIELIST,'Set-Cookie: zentro_demo='.$identity.'; domain='.parse_url(cfg('APP_URL'),PHP_URL_HOST).'; path='.(base_path()?:'/'));
 $login=demoRequest('/login');preg_match('/name="csrf" value="([a-f0-9]+)"/',$login,$m);$csrf=$m[1];demoRequest('/api/v1/guest-demo',['csrf'=>$csrf,'tool'=>'qr','operation'=>'use'],401);
 $email='demo-test-'.bin2hex(random_bytes(8)).'@example.test';$password=bin2hex(random_bytes(20));query("INSERT INTO users(name,email,password,role,verified_at) VALUES (?,?,?,'customer',NOW())",['Demo test',$email,password_hash($password,PASSWORD_DEFAULT)]);$uid=(int)db()->lastInsertId();
 demoRequest('/login',['csrf'=>$csrf,'email'=>$email,'password'=>$password],303);$home=demoRequest('/');preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$home,$m);$csrf=$m[1];
 foreach(GuestDemo::TOOLS as $tool){$r=json_decode(demoRequest('/api/v1/guest-demo',['csrf'=>$csrf,'tool'=>$tool,'operation'=>'use']),true);checkDemo($r['data']['signed_in']===true&&$r['data']['remaining']===null,$tool.' continues after login');}
 foreach(['/about','/features','/how-it-works','/pricing','/seo-tools'] as $path)checkDemo(str_contains(demoRequest($path),'page-guide'),'Informative content on '.$path);
 checkDemo(str_contains(demoRequest('/hire-seo-expert'),'expert-faq'),'Expert hiring FAQ');echo "PASS $checks demo checks\n";
}finally{curl_close($c);if($identity)foreach(GuestDemo::TOOLS as $tool)query('DELETE FROM rate_limits WHERE bucket=?',[hash('sha256','zentro-demo|'.$identity.'|'.$tool)]);if($uid){query('DELETE FROM audit_logs WHERE user_id=?',[$uid]);query('DELETE FROM auth_tokens WHERE user_id=?',[$uid]);query('DELETE FROM users WHERE id=?',[$uid]);}}
