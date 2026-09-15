<?php
/** Creates and removes its own randomly named database; never changes application leads. */
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
$testDb='seo_autopilot_test_b2b_'.bin2hex(random_bytes(5));
$server=new PDO('mysql:host='.cfg('DB_HOST').';port='.cfg('DB_PORT'),cfg('DB_USER'),cfg('DB_PASS'),[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION]);
$server->exec('CREATE DATABASE `'.$testDb.'` CHARACTER SET utf8mb4');$config['DB_NAME']=$testDb;
$count=0;$process=null;$tempFiles=[];
function verifyLead(bool $ok,string $label): void {global $count;if(!$ok)throw new RuntimeException('FAIL '.$label);$count++;echo 'PASS '.$label."\n";}
function rejectLead(callable $fn,string $label): void {try{$fn();}catch(HttpError|PDOException $e){verifyLead(true,$label);return;}throw new RuntimeException('FAIL '.$label);}
try {
 foreach([ROOT.'/database/database.sql',...glob(ROOT.'/database/migrations/*.sql')] as $file)foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents($file)) as $sql)if(trim($sql)!=='')query($sql);
 BtoBLeads::migrate();verifyLead(BtoBLeads::ready(),'Migration installs and reruns safely');
 $discoveryInput=['keyword'=>'Packaging','location'=>'Mumbai','source_id'=>'1'];
 $found=BtoBLeads::discover($discoveryInput,static function($query,$country,$language){
  verifyLead($query==='site:indiamart.com "Packaging" "Mumbai"'&&$country==='IN'&&$language==='en','Discovery scopes search to marketplace and location');
  return ['organicResults'=>[
   ['title'=>'Fixture business','link'=>'https://www.indiamart.com/fixture/','snippet'=>'Packaging supplier'],
   ['title'=>'Duplicate','link'=>'https://www.indiamart.com/fixture/'],
   ['title'=>'Wrong domain','link'=>'https://indiamart.com.example.org/'],
   ['title'=>'Unsafe','link'=>'javascript:alert(1)']
  ]];
 });
 verifyLead(count($found)===1&&$found[0]['source_id']==='1'&&$found[0]['snippet']==='Packaging supplier','Discovery filters unsafe, duplicate and unrelated results');
 verifyLead((int)value('SELECT COUNT(*) FROM leads')===0,'Discovery does not save unreviewed search results');
 rejectLead(fn()=>BtoBLeads::discover(array_replace($discoveryInput,['keyword'=>''])),'Discovery requires keyword');
 rejectLead(fn()=>BtoBLeads::discover(array_replace($discoveryInput,['source_id'=>'3'])),'Discovery rejects unsupported source');
 rejectLead(fn()=>BtoBLeads::discover($discoveryInput,static function(){throw new RuntimeException('Provider unavailable');}),'Discovery surfaces provider errors');
 $record=['source_id'=>'1','business_name'=>'Fixture Packaging','category'=>'Packaging','city'=>'Mumbai','state'=>'Maharashtra','website'=>'https://example.com/','email'=>'public@example.com','phone'=>'+91 2222222222','provenance'=>'Isolated automated test fixture'];
 $valid=BtoBLeads::validate($record);verifyLead(BtoBLeads::scoring($valid)['score']===80,'Contact completeness scoring');
 verifyLead(BtoBLeads::scoring($valid+['website_available'=>1,'seo_score'=>0])['score']===100,'SEO opportunity scoring bounded');
 $response=['url'=>'https://example.com/','status'=>200,'body'=>'<html lang="en"><head><title>A clear business title</title><meta name="description" content="Packaging services"><meta name="viewport" content="width=device-width"></head><body><h1>Packaging</h1></body></html>','headers'=>['content-type'=>'text/html'],'ms'=>123,'redirects'=>[]];
 $snapshot=BtoBLeads::snapshot($response,'https://example.com',200,'Found at /sitemap.xml');verifyLead($snapshot['meta_title']==='A clear business title'&&$snapshot['h1']==='Packaging'&&$snapshot['load_ms']===123,'Lead audit extracts real page metadata and timing');
 verifyLead($snapshot['seo_score']===Audit::pageScore(Crawler::parse($response,'https://example.com')),'Lead audit uses existing SEO score engine');
 verifyLead(BtoBLeads::snapshot(array_replace($response,['status'=>503]),'https://example.com',200,'Not checked')['seo_score']===null,'Unavailable websites never receive an SEO score');
 verifyLead(BtoBLeads::snapshot(array_replace($response,['headers'=>['content-type'=>'application/pdf']]),'https://example.com',200,'Not checked')['seo_score']===null,'Non-HTML responses never receive an SEO score');
 rejectLead(fn()=>BtoBLeads::validate(array_replace($record,['source_id'=>'3'])),'Unknown source rejected');
 rejectLead(fn()=>BtoBLeads::validate(array_replace($record,['website'=>'javascript:alert(1)'])),'Unsafe website rejected');
 rejectLead(fn()=>BtoBLeads::validate(array_replace($record,['website'=>'http://127.0.0.1/'])),'Private literal website rejected');
 rejectLead(fn()=>BtoBLeads::validate(array_replace($record,['email'=>'invalid'])),'Invalid email rejected');
 rejectLead(fn()=>BtoBLeads::validate(array_replace($record,['business_name'=>['bad']])),'Array input rejected');
 $id=BtoBLeads::save($record,1);rejectLead(fn()=>BtoBLeads::save(array_replace($record,['source_id'=>'2','business_name'=>'FIXTURE PACKAGING']),1),'Cross-source duplicate blocked');
 for($i=2;$i<=7;$i++)BtoBLeads::save(array_replace($record,['business_name'=>'Fixture Packaging '.$i]),1);
 query('UPDATE leads SET demo_slot=id WHERE id<=5');
 $demo=BtoBLeads::demo(['keyword'=>'Packaging','location'=>'Mumbai','source_id'=>'1','page'=>'2','limit'=>'999']);verifyLead(count($demo)===5,'Public requests cannot raise five-lead cap');
 verifyLead(!isset($demo[0]['provenance'],$demo[0]['id'],$demo[0]['created_by']),'Public results omit internal data');
 verifyLead(BtoBLeads::demo(['keyword'=>'Packaging 7','location'=>'Mumbai','source_id'=>'1'])===[],'Query changes cannot enumerate private leads');
 rejectLead(fn()=>query('UPDATE leads SET demo_slot=6 WHERE id=6'),'Database rejects sixth demo slot');
 [$where,$params]=BtoBLeads::filters(['keyword'=>"' OR 1=1 --"]);verifyLead((int)value('SELECT COUNT(*) FROM leads l WHERE '.$where,$params)===0,'Search injection treated as literal text');
 [$where,$params]=BtoBLeads::filters(['keyword'=>'%']);verifyLead((int)value('SELECT COUNT(*) FROM leads l WHERE '.$where,$params)===0,'LIKE wildcards escaped');
 rejectLead(fn()=>BtoBLeads::filters(['from'=>'2026-02-30']),'Invalid dates rejected');
 [$where,$params]=BtoBLeads::filters(['duplicates'=>'1']);verifyLead((int)value('SELECT COUNT(*) FROM leads l WHERE '.$where,$params)===7,'Shared contacts flagged as possible duplicates');
 $csv=tempnam(sys_get_temp_dir(),'b2b-test-');$tempFiles[]=$csv;
 file_put_contents($csv,"business_name,city,state\nFresh,Mumbai,Maharashtra\nFixture Packaging,Mumbai,Maharashtra\n");
 $import=BtoBLeads::import($csv,$record,1);verifyLead($import===['added'=>1,'duplicates'=>1],'CSV import reports inserted and skipped duplicates');
 $before=(int)value('SELECT COUNT(*) FROM leads');file_put_contents($csv,"business_name,city,email\nWould be valid,Mumbai,hello@example.com\nBroken,Mumbai,invalid\n");
 rejectLead(fn()=>BtoBLeads::import($csv,$record,1),'Invalid CSV row rejects import');verifyLead((int)value('SELECT COUNT(*) FROM leads')===$before,'Failed import inserts no partial data');
 $xlsx=tempnam(sys_get_temp_dir(),'b2b-test-');$tempFiles[]=$xlsx;LeadExport::xlsx([array_replace(BtoBLeads::get($id),['business_name'=>'=1+1'])],$xlsx);$zip=new ZipArchive();$zip->open($xlsx);$sheet=$zip->getFromName('xl/worksheets/sheet1.xml');verifyLead(str_contains($sheet,'=1+1')&&!str_contains($sheet,'<f>'),'Excel uses literal cells instead of formulas');$dom=new DOMDocument();verifyLead($dom->loadXML($sheet),'Excel worksheet is valid XML');$zip->close();verifyLead(BtoBLeads::csvCell(' =1+1')==="' =1+1",'CSV formula injection neutralized');
 query('UPDATE leads SET seo_score=20,website_available=1,seo_result=\'{"test":true}\' WHERE id=?',[$id]);
 BtoBLeads::save(array_replace($record,['website'=>'https://example.org/']),1,$id);$changed=BtoBLeads::get($id);verifyLead($changed['seo_score']===null&&$changed['seo_result']===null&&$changed['demo_slot']===null,'Website edits clear stale audits and public approval');
 $tradeId=BtoBLeads::save(array_replace($record,['source_id'=>'2','business_name'=>'Trade Fixture','city'=>'Delhi','state'=>'Delhi']),1);query('UPDATE leads SET demo_slot=1 WHERE id=?',[$tradeId]);
 $tradeDemo=BtoBLeads::demo(['keyword'=>'Packaging','location'=>'Delhi','source_id'=>'2']);verifyLead(count($tradeDemo)===1&&$tradeDemo[0]['source']==='TradeIndia','TradeIndia demo preserves source attribution');
 foreach([['source_id'=>'2'],['website'=>'no'],['email'=>'no'],['phone'=>'no'],['location'=>'Delhi'],['category'=>'Packaging','rating'=>'Hot','source_id'=>'2']] as $filter){[$where,$params]=BtoBLeads::filters($filter);verifyLead((int)value('SELECT COUNT(*) FROM leads l WHERE '.$where,$params)===1,'Filter '.json_encode($filter));}
 for($i=0;$i<20;$i++)BtoBLeads::save(array_replace($record,['business_name'=>'Pagination fixture '.$i]),1);
 $password=bin2hex(random_bytes(16));foreach(['admin','customer'] as $role)query('INSERT INTO users(name,email,password,role,verified_at) VALUES (?,?,?,?,NOW())',[$role,$role.'@example.test',password_hash($password,PASSWORD_DEFAULT),$role]);
 $socket=stream_socket_server('tcp://127.0.0.1:0');$address=stream_socket_get_name($socket,false);fclose($socket);$base='http://'.$address;
 $log=tempnam(sys_get_temp_dir(),'b2b-http-');$tempFiles[]=$log;$env=getenv();$env['DB_NAME']=$testDb;$env['APP_URL']=$base;
 $process=proc_open([PHP_BINARY,'-S',$address,ROOT.'/tests/router.php'],[0=>['pipe','r'],1=>['file',$log,'a'],2=>['file',$log,'a']],$pipes,ROOT,$env,['bypass_shell'=>true]);if(!is_resource($process))throw new RuntimeException('Cannot start test server.');fclose($pipes[0]);
 $jar=tempnam(sys_get_temp_dir(),'b2b-cookie-');$tempFiles[]=$jar;
 $http=static function(string $path,?array $data=null)use($base,$jar):array{$ch=curl_init($base.$path);curl_setopt_array($ch,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEJAR=>$jar,CURLOPT_COOKIEFILE=>$jar,CURLOPT_TIMEOUT=>15,CURLOPT_PROXY=>'']);if($data!==null)curl_setopt_array($ch,[CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>http_build_query($data)]);$body=curl_exec($ch);$status=curl_getinfo($ch,CURLINFO_RESPONSE_CODE);curl_close($ch);return [$status,(string)$body];};
 for($i=0;$i<30;$i++){[$status,$body]=$http('/');if($status)break;usleep(100000);}
 verifyLead($status===200&&str_contains($body,'Find B2B Leads by Keyword'),'Homepage demo renders');preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$body,$m);$csrf=$m[1]??'';
 verifyLead($http('/api/v1/b2b-leads',['operation'=>'export'])[0]===401,'Anonymous management blocked');
 verifyLead($http('/api/v1/b2b-demo',['keyword'=>'Packaging','location'=>'Mumbai','source_id'=>'1'])[0]===419,'Public demo enforces CSRF');
 [$status,$body]=$http('/api/v1/b2b-demo',['csrf'=>$csrf,'keyword'=>'Packaging','location'=>'Mumbai','source_id'=>'1']);verifyLead($status===200&&count(json_decode($body,true)['data']['leads'])<=5,'Public HTTP demo limited');
 verifyLead($http('/login',['csrf'=>$csrf,'email'=>'admin@example.test','password'=>$password])[0]===303,'Admin login succeeds');
 [$status,$body]=$http('/admin/b2b-leads');verifyLead($status===200&&str_contains($body,'Lead directory'),'Admin module renders');preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$body,$m);$csrf=$m[1];
 [$pageStatus,$pageBody]=$http('/admin/b2b-leads?page=2');verifyLead($pageStatus===200&&str_contains($pageBody,'Page 2 of 2'),'Pagination serves second page');
 [$pageStatus,$pageBody]=$http('/admin/b2b-leads?page=9999');verifyLead($pageStatus===200&&str_contains($pageBody,'Page 2 of 2'),'Out-of-range pages clamp safely');
 verifyLead($http('/api/v1/b2b-leads',['operation'=>'save'])[0]===419,'Admin writes enforce CSRF');
 [$status,$body]=$http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>'save','authorized'=>'1']+array_replace($record,['business_name'=>'HTTP Fixture']));verifyLead($status===200,'Admin can create lead');$httpId=(int)value("SELECT id FROM leads WHERE business_name='HTTP Fixture'");
 foreach(['favorite','note','tags'] as $operation)verifyLead($http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>$operation,'id'=>$httpId,'note'=>'Follow up','tags'=>'prospect, packaging'])[0]===200,'Admin '.$operation.' action');
 verifyLead($http('/admin/b2b-leads?id='.$httpId)[0]===200,'Lead details render');
 [$status,$body]=$http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>'export','format'=>'xlsx']);verifyLead($status===200&&str_starts_with($body,'PK'),'Excel endpoint returns XLSX');
 [$status,$body]=$http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>'export','format'=>'csv','ids'=>[(string)$httpId]]);verifyLead($status===200&&str_contains($body,'HTTP Fixture')&&!str_contains($body,'Fixture Packaging'),'Selected CSV export excludes other leads');
 verifyLead($http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>'delete','id'=>$httpId])[0]===422,'Delete requires explicit confirmation');
 verifyLead($http('/api/v1/b2b-leads',['csrf'=>$csrf,'operation'=>'delete','id'=>$httpId,'confirm_delete'=>'1'])[0]===200,'Confirmed delete succeeds');verifyLead((int)value('SELECT COUNT(*) FROM lead_notes WHERE lead_id=?',[$httpId])===0,'Delete cascades notes');
 if(in_array('--browser',$argv,true)){
  $browserEnv=getenv();$browserEnv['B2B_TEST_URL']=$base;$browserEnv['B2B_TEST_PASSWORD']=$password;
  $browser=proc_open([getenv('B2B_NODE')?:'node',ROOT.'/tests/b2b-browser.cjs'],[0=>['pipe','r'],1=>STDOUT,2=>STDERR],$browserPipes,ROOT,$browserEnv,['bypass_shell'=>true]);if(!is_resource($browser))throw new RuntimeException('Cannot launch browser tests.');fclose($browserPipes[0]);verifyLead(proc_close($browser)===0,'Desktop and mobile browser workflows');
 }
 $http('/logout',['csrf'=>$csrf]);[$status,$body]=$http('/login');preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$body,$m);$http('/login',['csrf'=>$m[1],'email'=>'customer@example.test','password'=>$password]);
 verifyLead($http('/admin/b2b-leads')[0]===403,'Customer cannot view admin leads');verifyLead($http('/api/v1/b2b-leads',['operation'=>'export'])[0]===403,'Customer cannot export leads');
 echo "PASS: $count B2B checks\n";
} finally {
 if(db()->inTransaction())db()->rollBack();if(is_resource($process)){proc_terminate($process);proc_close($process);}
 foreach($tempFiles as $file)if(is_file($file))unlink($file);
 if(preg_match('/^seo_autopilot_test_b2b_[a-f0-9]{10}$/D',$testDb))$server->exec('DROP DATABASE `'.$testDb.'`');
}
