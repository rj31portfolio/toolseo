<?php
// Optional public-page smoke test; never uses cookies, alternate APIs or bypasses.
require dirname(__DIR__).'/includes/bootstrap.php';
$url=$argv[1]??'https://www.instagram.com/p/C/';
try{$result=InstagramDownloader::extract($url);echo 'Public metadata returned: '.$result['type']."\n";if(in_array('--download',$argv,true)){$file=InstagramDownloader::download($result['media'],$result['type']);echo 'Downloaded '.$file['bytes'].' bytes; verified '.$file['mime']."\n";fclose($file['file']);}}
catch(RuntimeException $e){echo 'Public-page limitation: '.$e->getMessage()."\n";}
