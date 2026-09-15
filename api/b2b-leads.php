<?php
header('Cache-Control: no-store');
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Use POST for this endpoint.',405);
if($section==='api/v1/b2b-demo'){
 check_csrf();rate_limit('b2b-demo',10,600);
 if(!BtoBLeads::ready())json_response(['leads'=>[]],'No approved demo leads are available yet.');
 json_response(['leads'=>BtoBLeads::demo($_POST)],'Admin-approved imported leads only. Maximum five public leads; no live marketplace extraction.');
}
$user=require_admin();check_csrf();rate_limit('b2b-admin:'.$user['id'],60,60);
if(!BtoBLeads::ready())fail('Run cron/migrate-b2b-leads.php to install lead storage.',503);
$action=enum_input('operation',['save','import','delete','favorite','unfavorite','note','tags','demo','analyze','export']);
$id=(int)input('id',20,'0');$uid=(int)$user['id'];$message='Lead updated.';
if($action==='import'){
 if(input('authorized',1)!=='1')fail('Confirm that you are authorized to import this data.');
 $file=$_FILES['csv']??null;if(!$file||$file['error']!==UPLOAD_ERR_OK||!is_uploaded_file($file['tmp_name']))fail('Upload a CSV file, at most 2 MB.');
 if(strtolower(pathinfo($file['name'],PATHINFO_EXTENSION))!=='csv')fail('Only CSV imports are supported.');
 $result=BtoBLeads::import($file['tmp_name'],$_POST,$uid);$message=$result['added'].' leads imported; '.$result['duplicates'].' duplicates skipped.';
} elseif($action==='analyze'){
 rate_limit('b2b-audit:'.$uid,5,300);$lead=BtoBLeads::get($id);
 if($lead['audited_at']&&strtotime($lead['audited_at'])>time()-300)fail('This lead was audited recently. Wait five minutes before retrying.');
 session_write_close();set_time_limit(120);BtoBLeads::analyze($id,$uid);
} elseif($action==='export'){
 rate_limit('b2b-export:'.$uid,10,300);$format=enum_input('format',['csv','xlsx']);[$where,$params]=BtoBLeads::filters($_POST);
 $ids=$_POST['ids']??[];if(!is_array($ids)||count($ids)>100)fail('Select at most 100 leads.');foreach($ids as $v)if(!is_string($v)||!ctype_digit($v))fail('Invalid lead selection.');
 if($ids){$where.=' AND l.id IN ('.implode(',',array_fill(0,count($ids),'?')).')';array_push($params,...$ids);}
 $records=rows('SELECT l.*,s.name AS source FROM leads l JOIN lead_sources s ON s.id=l.source_id WHERE '.$where.' ORDER BY l.id DESC LIMIT 10001',$params);
 if(count($records)>10000)fail('Export is limited to 10,000 leads. Narrow your filters.');
 BtoBLeads::activity(null,$uid,'exported',['format'=>$format,'count'=>count($records)]);LeadExport::download($records,$format);
} else {
 db()->beginTransaction();
 try {
  if($action==='save'){
   if(input('authorized',1)!=='1')fail('Confirm authorization to store this business information.');
   $id=BtoBLeads::save($_POST,$uid,$id);
  } elseif(in_array($action,['delete','favorite','unfavorite'],true)){
   $ids=$_POST['ids']??($id?[(string)$id]:[]);if(!is_array($ids)||!$ids||count($ids)>100)fail('Select 1–100 leads.');
   if($action==='delete'&&input('confirm_delete',1)!=='1')fail('Confirm deletion of the selected leads.');
   foreach(array_unique($ids) as $v){if(!is_string($v)||!ctype_digit($v))fail('Invalid lead selection.');$lead=BtoBLeads::get((int)$v,true);BtoBLeads::activity((int)$v,$uid,$action,['lead_id'=>(int)$v]);if($action==='delete')query('DELETE FROM leads WHERE id=?',[$v]);else query('UPDATE leads SET favorite=? WHERE id=?',[$action==='favorite'?1:0,$v]);}
   $id=0;$message='Selected leads updated.';
  } else {
   BtoBLeads::get($id,true);
   if($action==='note')query('INSERT INTO lead_notes(lead_id,user_id,note) VALUES (?,?,?)',[$id,$uid,required_input('note',5000)]);
   if($action==='tags'){$tags=array_filter(array_map('trim',explode(',',input('tags',600))));if(count($tags)>10)fail('Use at most ten tags.');query('DELETE FROM lead_tags WHERE lead_id=?',[$id]);foreach(array_unique($tags) as $tag){if(mb_strlen($tag)>60)fail('Tags must be at most 60 characters.');query('INSERT INTO lead_tags(lead_id,tag) VALUES (?,?)',[$id,$tag]);}}
   if($action==='demo'){$slot=enum_input('demo_slot',['','1','2','3','4','5']);if($slot!==''&&input('public_authorized',1)!=='1')fail('Confirm permission to publicly display all lead fields.');try{query('UPDATE leads SET demo_slot=? WHERE id=?',[$slot===''?null:(int)$slot,$id]);}catch(PDOException $e){if(($e->errorInfo[1]??0)===1062)fail('That public demo slot is occupied. Remove its current lead first.',409);throw $e;}}
   BtoBLeads::activity($id,$uid,$action);
  }
  db()->commit();
 }catch(Throwable $e){db()->rollBack();throw $e;}
}
json_response(['redirect'=>url('/admin/b2b-leads'.($id?'?id='.$id:''))],$message);
