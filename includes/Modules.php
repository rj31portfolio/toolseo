<?php
final class Modules {
 public static function definitions(): array { return [
 'keywords'=>['table'=>'keywords','title'=>'Keywords','description'=>'The searches that matter to your business.','fields'=>['keyword'=>'Keyword','country'=>'Country','language'=>'Language','search_engine'=>'Search engine','device'=>['Device',['desktop','mobile']],'target_url'=>'Target URL','intent'=>'Search intent','tags'=>'Tags'],'columns'=>['keyword'=>'Keyword','current_position'=>'Position','country'=>'Country','device'=>'Device','intent'=>'Intent','tags'=>'Tags','search_volume'=>'Volume','source'=>'Source']],
 'competitors'=>['table'=>'competitors','title'=>'Competitors','description'=>'Keep your competitive landscape in view. Third-party metrics require a data provider.','fields'=>['domain'=>'Competitor website URL','notes'=>'Notes'],'columns'=>['domain'=>'Domain','notes'=>'Notes','created_at'=>'Added']],
 'backlinks'=>['table'=>'backlinks','title'=>'Backlinks','description'=>'Your link inventory. Manual and CSV data are labeled by source.','fields'=>['source_url'=>'Source URL','target_url'=>'Target URL','anchor'=>'Anchor text','follow'=>['Link attribute',['follow','nofollow']],'status'=>['Status',['active','lost']]],'columns'=>['source_url'=>'Source URL','target_url'=>'Target URL','anchor'=>'Anchor','follow'=>'Attribute','status'=>'Status','source'=>'Source','last_seen'=>'Last seen']],
 'content'=>['table'=>'content_projects','title'=>'Content planner','description'=>'Bring search intent, useful ideas, and a clear plan together.','fields'=>['topic'=>'Topic','keyword'=>'Target keyword','audience'=>'Audience','country'=>'Country','language'=>'Language'],'columns'=>['topic'=>'Topic','keyword'=>'Keyword','audience'=>'Audience','status'=>'Status','created_at'=>'Created']],
 'tasks'=>['table'=>'seo_tasks','title'=>'SEO tasks','description'=>'Turn your next opportunity into progress.','fields'=>['title'=>'Task','url'=>'Page URL','priority'=>['Priority',['critical','high','medium','low']],'due_date'=>'Due date','notes'=>'Notes','status'=>['Status',['open','in_progress','waiting','completed','rejected']]],'columns'=>['title'=>'Task','priority'=>'Priority','status'=>'Status','due_date'=>'Due date','assigned_user'=>'Assignee']],
 'human-services'=>['table'=>'human_service_requests','title'=>'Expert SEO services','description'=>'Choose a service, share your goals and track your request.','fields'=>['service'=>['Service',['SEO Audit Review','Technical SEO','On-Page SEO','Keyword Research','Content Optimization','Local SEO','Monthly SEO Management']],'budget'=>'Budget (INR)','description'=>'Tell us what you need','priority'=>['Priority',['high','medium','low']]],'columns'=>['service'=>'Service','budget'=>'Budget (INR)','priority'=>'Priority','status'=>'Status','created_at'=>'Requested']],
 ]; }
 public static function save(string $module,array $w): int {
  $def=self::definitions()[$module]??null;if(!$def)fail('Module not found.',404);$id=(int)($_POST['id']??0);$table=$def['table'];
  if($id && !row("SELECT id FROM $table WHERE id=? AND website_id=?",[$id,$w['id']]))fail('Record not found.',404);
  if($module==='human-services')owned_website((int)$w['id']);
  $data=[];foreach($def['fields'] as $key=>$label){if(is_array($label))$data[$key]=enum_input($key,$label[1],$label[1][0]);else$data[$key]=input($key,in_array($key,['description','notes'])?10000:($key==='keyword'?190:500));}
  $first=array_key_first($def['fields']);if($data[$first]==='')fail('Please fill in '.$first.'.');
  foreach(['source_url','target_url','url','domain'] as $key)if(!empty($data[$key])){try{$data[$key]=SafeHttp::normalize($data[$key]);}catch(Throwable $e){fail($e->getMessage());}}
  if($module==='tasks'){$data['due_date']=$data['due_date']?:null;if($data['due_date']){$date=DateTimeImmutable::createFromFormat('!Y-m-d',$data['due_date']);if(!$date || $date->format('Y-m-d')!==$data['due_date'])fail('Use a valid due date.');}}
  if($module==='backlinks'){if($data['target_url']==='')fail('A target URL is required to verify a backlink.');$data['domain']=parse_url($data['source_url'],PHP_URL_HOST);if(!$id){$data['first_seen']=date('Y-m-d');$data['last_seen']=date('Y-m-d');}}
  if($module==='human-services'){$data['user_id']=require_user()['id'];if(!ctype_digit($data['budget'])||(int)$data['budget']>100000000)fail('Enter a valid whole-number budget.');if(!$data['description'])fail('Describe the work you need.');}
  if($module==='keywords'){foreach(['country'=>'India','language'=>'en','search_engine'=>'google'] as $k=>$default)$data[$k]=$data[$k]?:$default;if(mb_strlen($data['keyword'])>190)fail('Keyword too long.');}
  db()->beginTransaction();query('SELECT id FROM users WHERE id=? FOR UPDATE',[$w['user_id']]);
  if($module==='keywords' && !$id)limit_check((int)$w['user_id'],'keywords',(int)value('SELECT COUNT(*) FROM keywords k JOIN websites w ON w.id=k.website_id WHERE w.user_id=?',[$w['user_id']]));
  if($id){$sets=implode(',',array_map(fn($k)=>$k.'=?',array_keys($data)));query("UPDATE $table SET $sets WHERE id=? AND website_id=?",array_merge(array_values($data),[$id,$w['id']]));}
  else{$data['website_id']=$w['id'];query("INSERT INTO $table (".implode(',',array_keys($data)).') VALUES ('.implode(',',array_fill(0,count($data),'?')).')',array_values($data));$id=(int)db()->lastInsertId();}
  if($module==='backlinks')query('DELETE FROM website_settings WHERE website_id=? AND name=?',[$w['id'],'backlink_check_'.$id]);
  audit_log($module.'.saved',['id'=>$id,'website_id'=>$w['id']]);db()->commit();return $id;
 }
}
