<?php
// Run from the operating system scheduler every five minutes.
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
date_default_timezone_set('UTC');
$root=dirname(__DIR__);
$lock=fopen($root.'/storage/worker.guard','c');
if(!$lock||!flock($lock,LOCK_EX|LOCK_NB))exit;
$failed=false;
try{
 foreach(['crawl','rankings','reports','cleanup','notifications'] as $job){
  $process=proc_open([PHP_BINARY,$root.'/cron/'.$job.'.php'],[
   0=>['pipe','r'],1=>['file',$root.'/storage/logs/worker.log','a'],2=>['file',$root.'/storage/logs/worker.log','a']
  ],$pipes,$root,null,['bypass_shell'=>true,'create_no_window'=>true]);
  if(!is_resource($process)){$failed=true;continue;}
  fclose($pipes[0]);$status=proc_close($process);
  file_put_contents($root.'/storage/logs/worker.log',date(DATE_ATOM).' '.$job.' exit='.$status.PHP_EOL,FILE_APPEND|LOCK_EX);
  if($status!==0)$failed=true;
 }
}finally{flock($lock,LOCK_UN);fclose($lock);}
exit($failed?1:0);
