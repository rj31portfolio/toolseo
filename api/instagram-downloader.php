<?php
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Method not allowed.',405);
if(!InstagramDownloader::settings()['enabled'])fail('This tool is currently disabled.',404);
check_csrf();header('Cache-Control: no-store');
if($section==='api/v1/instagram-media'){
 rate_limit('instagram-media',10,60);
 $token=required_input('token',64);$media=$_SESSION['instagram_media'][$token]??null;
 if(!$media||($media['expires']??0)<time()||($media['version']??0)!==2)fail('This download link expired. Check the Instagram URL again.',410);
 session_write_close();set_time_limit(100);
 try{$download=InstagramDownloader::download($media['url'],$media['type']);}catch(Throwable $e){fail($e instanceof RuntimeException?$e->getMessage():'The media could not be downloaded. Please try again.',502);}
 header('Content-Type: '.$download['mime']);header('Content-Disposition: attachment; filename="instagram-'.($media['type']==='video'?'video':'image').'.'.$download['extension'].'"');header('Content-Length: '.$download['bytes']);
 fpassthru($download['file']);fclose($download['file']);exit;
}
rate_limit('instagram-page',10,60);
try{$url=InstagramDownloader::normalize(required_input('url',2048));}catch(InvalidArgumentException $e){fail($e->getMessage());}
session_write_close();set_time_limit(45);
try{$result=InstagramDownloader::extract($url);}catch(Throwable $e){fail($e instanceof RuntimeException?$e->getMessage():'Instagram metadata could not be read. Please try again.',502);}
if(!$result['downloadable']){unset($result['media']);json_response($result,'Video unavailable in public metadata');}
session_start();
$_SESSION['instagram_media']=array_filter($_SESSION['instagram_media']??[],fn($item)=>$item['expires']>=time());
while(count($_SESSION['instagram_media'])>=10)array_shift($_SESSION['instagram_media']);
$token=bin2hex(random_bytes(24));$_SESSION['instagram_media'][$token]=['url'=>$result['media'],'type'=>$result['type'],'expires'=>time()+600,'version'=>2];
unset($result['media']);$result['token']=$token;session_write_close();json_response($result,'Public metadata found');
