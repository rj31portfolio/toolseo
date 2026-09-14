<?php
$localTool=$_GET['tool']??null;
if($localTool!==null){
 if(!is_string($localTool)||!isset(WorkspaceUI::utilities()['tools/'.$localTool]))fail('Tool not found.',404);
 require ROOT.'/includes/no-api-tools.php';
}else{
 require ROOT.'/admin/domain-dns.php';
 require ROOT.'/admin/live-chat.php';
 require ROOT.'/admin/instagram-downloader.php';
 $directoryItems=WorkspaceUI::utilities();$directoryAdmin=true;
 require ROOT.'/includes/service-directory.php';
}
