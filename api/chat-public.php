<?php
header('Cache-Control: no-store');session_write_close();
if(!LiveChat::ready())fail('Chat is not available yet.',503);
$id=$_GET['widget']??'';if(!is_string($id)||!preg_match('/^[a-f0-9]{32}$/D',$id))fail('Widget not found.',404);
$widget=row('SELECT w.* FROM chat_widgets w JOIN users u ON u.id=w.user_id WHERE w.public_id=? AND w.enabled=1 AND u.active=1',[$id]);if(!$widget)fail('Widget is unavailable.',404);
$origin=$_SERVER['HTTP_ORIGIN']??LiveChat::appOrigin();
$origins=json_decode($widget['allowed_origins'],true)?:[];$origins[]=LiveChat::appOrigin();
if(!in_array($origin,$origins,true))fail('This website is not allowed to use this widget.',403);
header('Access-Control-Allow-Origin: '.$origin);header('Vary: Origin');header('Access-Control-Allow-Methods: GET, POST, OPTIONS');header('Access-Control-Allow-Headers: Content-Type');header('Access-Control-Max-Age: 600');
if($_SERVER['REQUEST_METHOD']==='OPTIONS'){http_response_code(204);exit;}
$action=substr($section,9);$chatConfig=LiveChat::config($widget);
if($_SERVER['REQUEST_METHOD']==='GET'&&$action==='config')json_response(LiveChat::publicConfig($widget));
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Method not allowed.',405);
if((int)($_SERVER['CONTENT_LENGTH']??0)>12000)fail('Chat request is too large.',413);
$raw=file_get_contents('php://input',false,null,0,12001);if(strlen($raw)>12000)fail('Chat request is too large.',413);
try{$data=json_decode($raw,true,16,JSON_THROW_ON_ERROR);}catch(Throwable){fail('Invalid chat request.');}if(!is_array($data))fail('Invalid chat request.');
$token=$data['token']??'';if(!is_string($token))fail('Invalid conversation token.');
if($action==='start'){
 rate_limit('chat-start-global',30,3600);rate_limit('chat-start:'.$id,10,600);
 $token=bin2hex(random_bytes(32));db()->beginTransaction();query('INSERT INTO chat_conversations(widget_id,token_hash,origin,expires_at) VALUES (?,?,?,DATE_ADD(NOW(),INTERVAL 7 DAY))',[$widget['id'],hash('sha256',$token),$origin]);$cid=(int)db()->lastInsertId();
 LiveChat::message($cid,'assistant',$chatConfig['welcome']."\n\n".$widget['business_info'].(!$chatConfig['online']?"\n\n".$chatConfig['offline']:''));db()->commit();json_response(['token'=>$token,'messages'=>LiveChat::history($cid),'mode'=>'bot','lead_captured'=>false]);
}
if(!in_array($action,['poll','message','lead'],true))fail('Unknown chat action.',404);
rate_limit('chat-'.$action.':'.$id,$action==='poll'?120:30,60);
db()->beginTransaction();$conversation=LiveChat::conversation($widget,$token,$origin,true);$cid=(int)$conversation['id'];
if($action==='message'){
 if($conversation['mode']==='closed')fail('This conversation is closed. Start a new chat.',409);
 $body=$data['message']??'';$client=$data['client_id']??'';if(!is_string($body)||trim($body)===''||mb_strlen($body)>2000||!is_string($client)||!preg_match('/^[a-zA-Z0-9-]{8,64}$/D',$client))fail('Enter a message of up to 2,000 characters.');
 if(!value('SELECT id FROM chat_messages WHERE conversation_id=? AND client_id=?',[$cid,$client])){
  if((int)value('SELECT COUNT(*) FROM chat_messages WHERE conversation_id=?',[$cid])>=290)fail('This conversation has reached its message limit. Start a new chat.',409);
  LiveChat::message($cid,'visitor',trim($body),$client);
  if($conversation['mode']==='bot')LiveChat::message($cid,'assistant',$chatConfig['online']?LiveChat::reply(trim($body),rows('SELECT question,keywords,answer FROM chat_knowledge WHERE widget_id=? ORDER BY id',[$widget['id']]),$widget['business_info']):$chatConfig['offline']);
  query('UPDATE chat_conversations SET updated_at=NOW() WHERE id=?',[$cid]);
 }
}
if($action==='lead'){
 if(!value('SELECT id FROM chat_leads WHERE conversation_id=?',[$cid])){
  $lead=LiveChat::leadInput($data,$chatConfig);$score=LiveChat::score($lead);$status='New';
  foreach(rows('SELECT * FROM chat_automation_rules WHERE widget_id=? AND enabled=1 ORDER BY id',[$widget['id']]) as $rule)if($score>=(int)$rule['min_score']&&($rule['keyword']===''||mb_stripos($lead['service'].' '.$lead['message'],$rule['keyword'])!==false)){$status=$rule['target_status'];break;}
  query('INSERT INTO chat_leads(widget_id,conversation_id,name,phone,email,service,message,status,score,notes,consent_at) VALUES (?,?,?,?,?,?,?,?,?,\'\',NOW())',[$widget['id'],$cid,$lead['name'],$lead['phone'],$lead['email'],$lead['service'],$lead['message'],$status,$score]);$lid=(int)db()->lastInsertId();
  LiveChat::message($cid,'system','Contact request submitted.');LiveChat::message($cid,'assistant','Thank you. Your details have been sent to our team so they can follow up about your request.');
  if($chatConfig['notify'])notify((int)$widget['user_id'],'New chat lead for '.$widget['name'],'/live-chat?tab=lead&id='.$lid);
  query('UPDATE chat_conversations SET updated_at=NOW() WHERE id=?',[$cid]);
 }
}
$after=$action==='poll'?($data['after']??0):0;if(!is_int($after)||$after<0)fail('Invalid message cursor.');
$leadCaptured=(bool)value('SELECT id FROM chat_leads WHERE conversation_id=?',[$cid]);$messages=LiveChat::history($cid,$after);db()->commit();json_response(['messages'=>$messages,'partial'=>$after>0,'mode'=>$conversation['mode'],'lead_captured'=>$leadCaptured]);
