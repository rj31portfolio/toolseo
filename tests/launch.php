<?php
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
$count=0;
function verify(bool $ok,string $label):void{global $count;if(!$ok)throw new RuntimeException($label);$count++;echo "PASS $label\n";}
verify(BusinessLeads::parameters('google-maps','dentists','Delhi',2,'@28.61,77.20,14z')===['q'=>'dentists in Delhi','ll'=>'@28.61,77.20,14z','start'=>20],'Maps pagination');
verify(BusinessLeads::parameters('google-maps','dentists','Delhi',1)===['q'=>'dentists in Delhi'],'Maps first page without coordinates');
verify(BusinessLeads::parameters('yelp','dentists','New York',2)['start']===10,'Yelp pagination');
verify(BusinessLeads::parameters('yellow-pages','dentists','New York',2)['page']===2,'Yellow Pages pagination');
foreach(['localResults','organicResults','searchResults'] as $key){$data=BusinessLeads::parse([$key=>[['title'=>'Test Clinic','website'=>'javascript:alert(1)','phone'=>'+91 1234567890'],['title'=>'Test Clinic','website'=>'javascript:alert(1)','phone'=>'+91 1234567890']]]);verify(count($data)===1&&reset($data)['website']==='','Deduplication and URL safety: '.$key);}
try{BusinessLeads::parse(['unexpected'=>[]]);verify(false,'Malformed response');}catch(RuntimeException){verify(true,'Malformed response rejected');}
$client=curl_init();curl_setopt_array($client,[CURLOPT_RETURNTRANSFER=>true,CURLOPT_COOKIEFILE=>'',CURLOPT_FOLLOWLOCATION=>false,CURLOPT_TIMEOUT=>30,CURLOPT_PROXY=>'']);
function visit(string $path,?array $data=null,int $expected=200):string{global $client;curl_setopt($client,CURLOPT_URL,rtrim(cfg('APP_URL'),'/').$path);if($data===null)curl_setopt($client,CURLOPT_HTTPGET,true);else curl_setopt_array($client,[CURLOPT_POST=>true,CURLOPT_POSTFIELDS=>$data]);$body=curl_exec($client);verify($body!==false&&curl_getinfo($client,CURLINFO_RESPONSE_CODE)===$expected,$path.' HTTP '.$expected);return (string)$body;}
$uid=null;$pid=null;$fixture=null;$uploaded=null;
try{
 foreach(['/','/pricing','/features','/contact','/blog','/google-maps-leads','/yelp-leads','/yellow-pages-leads','/sitemap.xml','/robots.txt'] as $path){$body=visit($path);if($path==='/')verify(str_contains($body,'SEO Zentro')&&str_contains($body,'zentro-mark.svg'),'Homepage branding');if($path==='/robots.txt')verify(str_contains($body,'Sitemap:'),'Dynamic robots sitemap');}
 visit('/api/v1/admin/blog-save',['title'=>'forbidden'],401);
 $email='zentro-test-'.bin2hex(random_bytes(8)).'@example.test';$pass=bin2hex(random_bytes(20));query("INSERT INTO users(name,email,password,role,verified_at) VALUES (?,?,?,'super_admin',NOW())",['Launch test',$email,password_hash($pass,PASSWORD_DEFAULT)]);$uid=(int)db()->lastInsertId();
 $body=visit('/login');preg_match('/name="csrf" value="([a-f0-9]+)"/',$body,$m);visit('/login',['csrf'=>$m[1],'email'=>$email,'password'=>$pass],303);
 foreach(['/admin/google-maps-leads','/admin/yelp-leads','/admin/yellow-pages-leads','/admin/blog','/admin/settings'] as $path){$body=visit($path);verify(!str_contains($body,'HasData'),'Neutral provider branding '.$path);}
 preg_match('/name="csrf-token" content="([a-f0-9]+)"/',$body,$m);$csrf=$m[1];
 visit('/api/v1/admin/blog-save',['title'=>'no csrf'],419);
 $slug='launch-test-'.bin2hex(random_bytes(6));$data=['csrf'=>$csrf,'slug'=>$slug,'title'=>'Launch test','description'=>'Test description','content'=>"## Safe heading\n\n<script>alert(1)</script>",'status'=>'draft'];
 $fixture=ROOT.'/storage/launch-image-'.bin2hex(random_bytes(5)).'.png';$im=imagecreatetruecolor(80,60);imagepng($im,$fixture);imagedestroy($im);$data['image']=new CURLFile($fixture,'image/png','cover.png');$data['image_alt']='Test cover';
 visit('/api/v1/admin/blog-save',$data);$pid=(int)value('SELECT id FROM zentro_posts WHERE slug=?',[$slug]);$uploaded=value('SELECT image FROM zentro_posts WHERE id=?',[$pid]);verify($pid>0,'Draft saved');verify(str_ends_with($uploaded,'.webp')&&is_file(ROOT.$uploaded),'Uploaded cover re-encoded to WebP');unset($data['image']);visit('/blog/'.$slug,null,404);
 $data['id']=$pid;$data['status']='published';visit('/api/v1/admin/blog-save',$data);$body=visit('/blog/'.$slug);verify(str_contains($body,'&lt;script&gt;')&&!str_contains($body,'<script>alert(1)'),'Article XSS protection');verify(str_contains($body,'BlogPosting'),'Article structured data');verify(str_contains(visit('/sitemap.xml'),'/blog/'.$slug),'Published article in sitemap');
 $data['status']='draft';visit('/api/v1/admin/blog-save',$data);visit('/blog/'.$slug,null,404);verify(!str_contains(visit('/sitemap.xml'),'/blog/'.$slug),'Unpublished article removed from sitemap');
 visit('/api/v1/admin/lead-export',['csrf'=>$csrf,'source'=>'yelp']);
 query("UPDATE users SET role='customer' WHERE id=?",[$uid]);visit('/api/v1/admin/lead-export',['csrf'=>$csrf,'source'=>'yelp'],403);visit('/admin/blog',null,403);
 echo "PASS $count launch checks\n";
}finally{curl_close($client);if($fixture&&is_file($fixture))unlink($fixture);if($uploaded&&preg_match('~^/assets/uploads/[a-f0-9]{32}\.webp$~',$uploaded)&&is_file(ROOT.$uploaded))unlink(ROOT.$uploaded);if($pid)query('DELETE FROM zentro_posts WHERE id=?',[$pid]);if($uid){query('DELETE FROM audit_logs WHERE user_id=?',[$uid]);query('DELETE FROM auth_tokens WHERE user_id=?',[$uid]);query('DELETE FROM users WHERE id=?',[$uid]);}}
