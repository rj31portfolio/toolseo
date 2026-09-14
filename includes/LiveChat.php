<?php
final class LiveChat {
 public const STATUSES=['New','Contacted','Qualified','Converted'];
 public static function ready(): bool {return (bool)value("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='chat_automation_rules'");}
 public static function migrate(): void {
  foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents(ROOT.'/database/migrations/007-live-chat.sql')) as $sql)if(trim($sql)!=='')query($sql);
 }
 public static function defaults(): array {return ['color'=>'#18634f','position'=>'right','size'=>'standard','button_style'=>'pill','logo'=>'','avatar'=>'Chat','welcome'=>'Welcome! How can we help you today?','placeholder'=>'Ask about our services…','offline'=>'Our team is away. Leave your details and we will follow up.','online'=>true,'mobile'=>true,'desktop'=>true,'branding'=>true,'notify'=>true,'fields'=>['name'=>'required','phone'=>'required','email'=>'required','service'=>'required','message'=>'optional']];}
 public static function origin(string $url): string {
  $p=parse_url(trim($url));if(!$p||!in_array($p['scheme']??'',['http','https'],true)||empty($p['host'])||isset($p['user'])||isset($p['pass'])||isset($p['query'])||isset($p['fragment'])||!in_array($p['path']??'',['','/'],true)||!preg_match('/^[a-z0-9.-]+$/i',$p['host']))throw new InvalidArgumentException('Use a website origin such as https://example.com, without a path.');
  $scheme=$p['scheme'];$port=$p['port']??($scheme==='https'?443:80);return $scheme.'://'.strtolower($p['host']).($port===($scheme==='https'?443:80)?'':':'.$port);
 }
 public static function appOrigin(): string {$p=parse_url(cfg('APP_URL'));return self::origin($p['scheme'].'://'.$p['host'].(isset($p['port'])?':'.$p['port']:''));}
 public static function config(array $w): array {return array_replace(self::defaults(),json_decode($w['config'],true)?:[]);}
 public static function owned(int $id,int $uid): array {$w=row('SELECT * FROM chat_widgets WHERE id=? AND user_id=?',[$id,$uid]);if(!$w)fail('Chat widget not found in your account.',404);return $w;}
 public static function configInput(): array {
  $c=self::defaults();$c['color']=required_input('color',7);if(!preg_match('/^#[a-f0-9]{6}$/i',$c['color']))fail('Choose a six-digit primary color.');
  foreach(['position'=>['left','right'],'size'=>['compact','standard','large'],'button_style'=>['pill','circle']] as $key=>$choices)$c[$key]=enum_input($key,$choices,$c[$key]);
  foreach(['logo'=>500,'avatar'=>30,'welcome'=>1000,'placeholder'=>120,'offline'=>1000] as $key=>$limit)$c[$key]=input($key,$limit,$c[$key]);
  if($c['logo']!==''){$p=parse_url($c['logo']);if(($p['scheme']??'')!=='https'||empty($p['host'])||isset($p['user'])||preg_match('/[\x00-\x20]/',$c['logo']))fail('Logo must be a public HTTPS image URL.');}
  foreach(['online','mobile','desktop','branding','notify'] as $key)$c[$key]=enum_input($key,['0','1'],'1')==='1';
  foreach(array_keys($c['fields']) as $key)$c['fields'][$key]=enum_input('field_'.$key,['required','optional','hidden'],$c['fields'][$key]);
  if($c['fields']['email']!=='required'&&$c['fields']['phone']!=='required')fail('Require either email or phone so your team can contact leads.');
  return $c;
 }
 public static function publicConfig(array $w): array {
  $c=self::config($w);unset($c['notify']);return ['name'=>$w['name'],'business_info'=>$w['business_info'],'config'=>$c];
 }
 public static function reply(string $question,array $knowledge,string $business): string {
  $text=mb_strtolower($question);$best=null;$bestScore=0;
  $tokens=array_unique(preg_split('/[^\p{L}\p{N}]+/u',$text,-1,PREG_SPLIT_NO_EMPTY));
  $stop=['what','which','where','when','your','you','are','the','and','can','how','for','about','tell','with','please','does','have'];
  foreach($knowledge as $item){$words=array_unique(preg_split('/[^\p{L}\p{N}]+/u',mb_strtolower($item['question'].' '.$item['keywords']),-1,PREG_SPLIT_NO_EMPTY));$score=0;foreach($tokens as $token)if(mb_strlen($token)>2&&!in_array($token,$stop,true)&&in_array($token,$words,true))$score++;
   if($score>$bestScore){$best=$item['answer'];$bestScore=$score;}}
  if($best!==null)return $best;
  if(preg_match('/^(hi|hello|hey)[!. ]*$/i',trim($question)))return 'Hello! '.$business;
  if(preg_match('/\b(services|business|offer|products)\b/i',$question))return $business;
  return "I don't have a confirmed answer to that in our business information. Leave your details and our team can help with your question.";
 }
 public static function score(array $lead): int {return min(100,($lead['name']!==''?15:0)+($lead['email']!==''?25:0)+($lead['phone']!==''?25:0)+($lead['service']!==''?20:0)+($lead['message']!==''?5:0)+(preg_match('/\b(quote|buy|book|demo|pricing|purchase)\b/i',$lead['service'].' '.$lead['message'])?10:0));}
 public static function leadInput(array $input,array $config): array {
  $lead=[];foreach(['name'=>120,'phone'=>40,'email'=>190,'service'=>190,'message'=>2000] as $key=>$max){$v=$input[$key]??'';if(!is_string($v)||mb_strlen($v)>$max)fail('Invalid '.$key.'.');$v=trim($v);$mode=$config['fields'][$key]??'optional';if($mode==='hidden')$v='';if($mode==='required'&&$v==='')fail(ucfirst($key).' is required.');$lead[$key]=$v;}
  if($lead['email']!==''&&!filter_var($lead['email'],FILTER_VALIDATE_EMAIL))fail('Enter a valid email address.');
  $digits=preg_replace('/\D/','',$lead['phone']);
  if($lead['phone']!==''&&(!preg_match('/^\+?[0-9 ()\-.]{7,40}$/D',$lead['phone'])||strlen($digits)<7||strlen($digits)>15))fail('Enter a valid phone number with 7 to 15 digits.');
  if($lead['email']===''&&$lead['phone']==='')fail('Provide an email address or phone number.');
  if(($input['consent']??false)!==true)fail('Please agree to be contacted about your request.');return $lead;
 }
 public static function conversation(array $w,string $token,string $origin,bool $lock=false): array {
  if(!preg_match('/^[a-f0-9]{64}$/D',$token))fail('Start a new conversation.',401);
  $c=row('SELECT * FROM chat_conversations WHERE widget_id=? AND token_hash=? AND origin=? AND expires_at>NOW()'.($lock?' FOR UPDATE':''),[$w['id'],hash('sha256',$token),$origin]);if(!$c)fail('This conversation expired. Start a new chat.',401);return $c;
 }
 public static function history(int $id,int $after=0): array {return rows('SELECT id,role,body,created_at FROM chat_messages WHERE conversation_id=? AND id>? ORDER BY id LIMIT 300',[$id,$after]);}
 public static function message(int $id,string $role,string $body,?string $client=null): void {query('INSERT INTO chat_messages(conversation_id,role,body,client_id) VALUES (?,?,?,?)',[$id,$role,$body,$client]);}
}
