<?php
if(!LiveChat::ready())fail('Chat storage is not installed. Ask an administrator to install it from Tools & services.',503);
$uid=(int)$user['id'];$op=substr($action,5);
if($op==='widget'){
 $id=(int)input('id',10,'0');if($id)LiveChat::owned($id,$uid);elseif((int)value('SELECT COUNT(*) FROM chat_widgets WHERE user_id=?',[$uid])>=50)fail('You can create up to 50 widgets.');
 $name=required_input('name',120);$info=required_input('business_info',10000);$config=LiveChat::configInput();$origins=[];
 foreach(preg_split('/[\r\n,]+/',required_input('allowed_origins',5000),-1,PREG_SPLIT_NO_EMPTY) as $origin)try{$origins[]=LiveChat::origin(trim($origin));}catch(InvalidArgumentException $e){fail($e->getMessage());}
 $origins=array_values(array_unique($origins));if(!$origins||count($origins)>20)fail('Enter between one and twenty website origins.');
 $params=[$name,$info,json_encode($config),json_encode($origins),(int)(enum_input('enabled',['0','1'],'1')==='1')];
 if($id)query('UPDATE chat_widgets SET name=?,business_info=?,config=?,allowed_origins=?,enabled=? WHERE id=? AND user_id=?',array_merge($params,[$id,$uid]));
 else{query('INSERT INTO chat_widgets(name,business_info,config,allowed_origins,enabled,user_id,public_id) VALUES (?,?,?,?,?,?,?)',array_merge($params,[$uid,bin2hex(random_bytes(16))]));$id=(int)db()->lastInsertId();}
 audit_log('chat.widget.saved',['id'=>$id]);json_response(['redirect'=>url('/live-chat?tab=widgets&widget='.$id)],'Widget saved');
}
if(in_array($op,['knowledge','knowledge-delete','automation','automation-delete'],true)){
 $w=LiveChat::owned((int)input('widget_id',10),$uid);$id=(int)input('id',10,'0');
 if($op==='knowledge'){if((int)value('SELECT COUNT(*) FROM chat_knowledge WHERE widget_id=?',[$w['id']])>=100)fail('Maximum 100 knowledge entries per widget.');query('INSERT INTO chat_knowledge(widget_id,question,keywords,answer) VALUES (?,?,?,?)',[$w['id'],required_input('question',300),input('keywords',500),required_input('answer',4000)]);}
 if($op==='knowledge-delete')query('DELETE FROM chat_knowledge WHERE id=? AND widget_id=?',[$id,$w['id']]);
 if($op==='automation'){$score=input('min_score',3,'0');if(!ctype_digit($score)||(int)$score>100)fail('Score must be between 0 and 100.');if((int)value('SELECT COUNT(*) FROM chat_automation_rules WHERE widget_id=?',[$w['id']])>=50)fail('Maximum 50 automation rules.');query('INSERT INTO chat_automation_rules(widget_id,name,keyword,min_score,target_status,enabled) VALUES (?,?,?,?,?,?)',[$w['id'],required_input('name',120),input('keyword',120),(int)$score,enum_input('target_status',LiveChat::STATUSES,'Qualified'),(int)(enum_input('enabled',['0','1'],'1')==='1')]);}
 if($op==='automation-delete')query('DELETE FROM chat_automation_rules WHERE id=? AND widget_id=?',[$id,$w['id']]);
 audit_log('chat.'.$op,['widget'=>$w['id']]);json_response(['redirect'=>url('/live-chat?tab='.(str_starts_with($op,'knowledge')?'knowledge':'automation').'&widget='.$w['id'])]);
}
if($op==='lead'){
 $id=(int)input('id',20);$lead=row('SELECT l.id FROM chat_leads l JOIN chat_widgets w ON w.id=l.widget_id WHERE l.id=? AND w.user_id=?',[$id,$uid]);if(!$lead)fail('Lead not found.',404);
 query('UPDATE chat_leads SET status=?,notes=? WHERE id=?',[enum_input('status',LiveChat::STATUSES),input('notes',5000),$id]);audit_log('chat.lead.updated',['id'=>$id]);json_response(['redirect'=>url('/live-chat?tab=lead&id='.$id)],'Lead updated');
}
if($op==='reply'||$op==='mode'){
 $id=(int)input('id',20);db()->beginTransaction();$conversation=row('SELECT c.* FROM chat_conversations c JOIN chat_widgets w ON w.id=c.widget_id WHERE c.id=? AND w.user_id=? FOR UPDATE',[$id,$uid]);if(!$conversation)fail('Conversation not found.',404);
 if($op==='reply'){if((int)value('SELECT COUNT(*) FROM chat_messages WHERE conversation_id=?',[$id])>=290)fail('Message limit reached.');LiveChat::message($id,'agent',required_input('message',2000));$mode='human';}else $mode=enum_input('mode',['bot','human','closed']);
 query('UPDATE chat_conversations SET mode=?,updated_at=NOW() WHERE id=?',[$mode,$id]);audit_log('chat.'.$op,['id'=>$id]);db()->commit();json_response(['redirect'=>url('/live-chat?tab=conversations&id='.$id)],'Conversation updated');
}
fail('Unknown chat action.',404);
