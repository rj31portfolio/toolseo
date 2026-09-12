<?php
require dirname(__DIR__).'/includes/bootstrap.php';
$total=0;
function check(bool $condition,string $name): void {global $total;if(!$condition)throw new RuntimeException('FAIL: '.$name);$total++;echo "PASS $name\n";}
function rejects(callable $fn,string $name): void {try{$fn();}catch(Throwable){check(true,$name);return;}check(false,$name);}
check(SafeHttp::normalize('HTTPS://Example.COM/a/../b#x')==='https://example.com/b','URL normalization');
check(SafeHttp::normalize('../c','https://example.com/a/b')==='https://example.com/c','Relative URL resolution');
check(SafeHttp::normalize('?a=1','https://example.com/a')==='https://example.com/a?a=1','Relative query resolution');
foreach(['file:///etc/passwd','ftp://example.com','gopher://127.0.0.1','http://user:pass@example.com','http://example.com:22','http://example.com\\@localhost'] as $url)rejects(fn()=>SafeHttp::normalize($url),'Reject unsafe URL '.$url);
foreach(['127.0.0.1','10.0.0.1','172.16.0.1','192.168.1.1','0.0.0.0','169.254.169.254','100.64.0.1','::1','fc00::1','::ffff:127.0.0.1'] as $ip)check(!SafeHttp::publicIp($ip),'Reject nonpublic IP '.$ip);
check(SafeHttp::publicIp('8.8.8.8'),'Allow public IPv4');
check(!Crawler::allowed('https://example.com/private',"User-agent: *\nDisallow: /private"),'Robots disallow');
check(Crawler::allowed('https://example.com/private/public',"User-agent: *\nDisallow: /private\nAllow: /private/public"),'Robots longest match');
$html='<html lang="en"><head><title>A useful page title for testing</title><meta name="description" content="A useful page description"><meta name="viewport" content="width=device-width"><link rel="canonical" href="https://example.com/"><script type="application/ld+json">{}</script></head><body><h1>Example heading</h1><h2>A useful section</h2><img src="a.jpg" alt="Picture"><img src="b.jpg"><a href="/next">Next</a><a href="https://other.example/">External</a><p>'.str_repeat('word ',320).'</p></body></html>';
$p=Crawler::parse(['body'=>$html,'url'=>'https://example.com/','status'=>200,'ms'=>100,'headers'=>[],'redirects'=>['https://example.com/']],'https://example.com/');
check($p['title']==='A useful page title for testing','Parse title');check($p['schema_count']===1,'Parse JSON-LD');check($p['missing_alt']===1,'Parse missing alt');check(count($p['internal_links'])===1&&count($p['external_links'])===1,'Classify links');check($p['word_count']>=320,'Count words');check(Audit::pageScore($p)>=0&&Audit::pageScore($p)<=100,'Score bounded');
$json=Schema::generate('Organization','{"name":"Example","url":"https://example.com"}');check(json_decode($json,true)['@type']==='Organization','Schema output');rejects(fn()=>Schema::generate('Organization','{broken}'),'Reject malformed schema JSON');
check(e('<script>')==='&lt;script&gt;','Output escaping');
echo "PASS: $total unit checks\n";
