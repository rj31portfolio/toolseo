<?php
final class SeoExpertManagement {
 public static function text(array $data,string $key,int $max): string {$v=$data[$key]??'';if(!is_string($v)||mb_strlen($v)>$max)fail('Invalid '.$key.'.');return trim($v);}
 public static function filters(array $data): array {
  $q=self::text($data,'q',190);$status=self::text($data,'status',30);$plan=self::text($data,'plan',20);$duration=self::text($data,'duration',2);
  $where=['1=1'];$params=[];
  foreach(['status'=>SeoExpert::STATUSES,'plan'=>['undecided',...array_keys(SeoExpert::PLANS)],'duration'=>['3','6','12']] as $key=>$allowed){$v=$$key;if($v==='')continue;if(!in_array($v,$allowed,true))fail('Invalid '.$key.' filter.');$where[]='e.'.$key.'=?';$params[]=$v;}
  if($q!==''){$where[]="(e.full_name LIKE ? ESCAPE '!' OR e.business_name LIKE ? ESCAPE '!' OR e.email LIKE ? ESCAPE '!' OR e.reference LIKE ? ESCAPE '!')";$like='%'.str_replace(['!','%','_'],['!!','!%','!_'],$q).'%';array_push($params,$like,$like,$like,$like);}
  return [implode(' AND ',$where),$params,compact('q','status','plan','duration')];
 }
 public static function id(string $key='id'): int {$v=input($key,18);if(!ctype_digit($v)||(int)$v<1)fail('Invalid '.str_replace('_',' ',$key).'.');return (int)$v;}
 public static function update(int $id): void {
  $old=SeoExpert::enquiry($id,true);$fields=SeoExpert::fields($_POST);
  $fields['status']=enum_input('status',SeoExpert::STATUSES);$fields['assigned_expert']=SeoExpert::expert(input('assigned_expert',18));
  $fields['follow_up_at']=SeoExpert::date(input('follow_up_at',16),true,true);$fields['proposal_amount']=SeoExpert::amount(input('proposal_amount',20),true);
  query('UPDATE seo_expert_enquiries SET '.implode(',',array_map(fn($k)=>$k.'=?',array_keys($fields))).' WHERE id=?',[...array_values($fields),$id]);
  $lead=SeoExpert::enquiry($id);SeoExpert::activate($lead);SeoExpert::syncPayment($id);
  audit_log('seo_expert.enquiry.updated',['id'=>$id,'from'=>$old['status'],'to'=>$fields['status']]);
 }
 public static function payment(int $id,int $uid): void {
  SeoExpert::enquiry($id,true);$amount=SeoExpert::amount(required_input('amount',20));if(!$amount)fail('Payment amount must be greater than zero.');
  $kind=enum_input('kind',['payment','refund']);$status=enum_input('payment_state',['pending','paid','failed','cancelled']);
  $date=SeoExpert::date(required_input('paid_on',10));$method=required_input('method',80);$reference=input('reference',190);
  $token=required_input('request_token',32);if(!preg_match('/^[a-f0-9]{32}$/D',$token))fail('Refresh the payment form.');$key=hash('sha256',$uid.'|'.$id.'|'.$token);
  query('INSERT INTO seo_expert_payments(enquiry_id,request_key,kind,amount,status,method,reference,paid_on,recorded_by) VALUES (?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE id=id',[$id,$key,$kind,$amount,$status,$method,$reference,$date,$uid]);
  SeoExpert::syncPayment($id);audit_log('seo_expert.payment.recorded',['enquiry_id'=>$id]);
 }
 public static function clientUpdate(int $id): void {
  $c=SeoExpert::client($id);SeoExpert::enquiry((int)$c['enquiry_id'],true);
  $website=SeoExpert::website(required_input('website',500));$plan=enum_input('plan',array_keys(SeoExpert::PLANS));$duration=(int)enum_input('duration',['3','6','12']);
  $start=SeoExpert::date(required_input('start_date',10));$end=SeoExpert::date(required_input('end_date',10));if($end<$start)fail('End date must be on or after start date.');
  $expert=SeoExpert::expert(input('assigned_expert',18));$keywords=required_input('target_keywords',3000);$location=required_input('target_location',190);$notes=input('notes',10000);
  $status=enum_input('client_status',['Active','Completed','On Hold']);
  query('UPDATE seo_expert_clients SET website=?,plan=?,duration=?,start_date=?,end_date=?,assigned_expert=?,target_keywords=?,target_location=?,notes=?,status=? WHERE id=?',[$website,$plan,$duration,$start,$end,$expert,$keywords,$location,$notes,$status,$id]);
  $leadStatus=$status==='On Hold'?'Contacted':$status;
  query('UPDATE seo_expert_enquiries SET website=?,plan=?,duration=?,listed_amount=?,assigned_expert=?,target_keywords=?,target_location=?,status=? WHERE id=?',[$website,$plan,$duration,SeoExpert::price($plan,$duration),$expert,$keywords,$location,$leadStatus,$c['enquiry_id']]);
  SeoExpert::syncPayment((int)$c['enquiry_id']);audit_log('seo_expert.client.updated',['id'=>$id]);
 }
 public static function clientEntry(string $operation,int $id): void {
  $c=SeoExpert::client($id);SeoExpert::enquiry((int)$c['enquiry_id'],true);
  if($operation==='task'){
   $month=input('month_number',2);if(!ctype_digit($month)||(int)$month<1||(int)$month>(int)$c['duration'])fail('Task month must be within the client program.');
   query('INSERT INTO seo_expert_tasks(client_id,month_number,title,due_date) VALUES (?,?,?,?)',[$id,(int)$month,required_input('title',300),SeoExpert::date(input('due_date',10),true)]);
  }elseif($operation==='task_status'){
   $task=self::id('task_id');if(!value('SELECT id FROM seo_expert_tasks WHERE id=? AND client_id=?',[$task,$id]))fail('Task not found.',404);
   query('UPDATE seo_expert_tasks SET status=? WHERE id=? AND client_id=?',[enum_input('task_status',['Todo','In Progress','Done']),$task,$id]);
  }elseif($operation==='ranking'){
   $position=input('position',4);if($position!==''&&(!ctype_digit($position)||(int)$position<1||(int)$position>1000))fail('Position must be 1–1000 or blank for not found.');
   query('INSERT INTO seo_expert_rankings(client_id,keyword,checked_on,position,target_url,source) VALUES (?,?,?,?,?,?) ON DUPLICATE KEY UPDATE position=VALUES(position),target_url=VALUES(target_url),source=VALUES(source)',[$id,required_input('keyword',190),SeoExpert::date(required_input('checked_on',10)),$position===''?null:(int)$position,SeoExpert::website(input('target_url',500),true),required_input('source',50)]);
  }elseif($operation==='report'){
   query('INSERT INTO seo_expert_reports(client_id,title,report_month,url,summary) VALUES (?,?,?,?,?)',[$id,required_input('title',190),SeoExpert::date(required_input('report_month',10)),SeoExpert::website(input('report_url',1000),true),required_input('summary',10000)]);
  }
  audit_log('seo_expert.client.'.$operation,['id'=>$id]);
 }
 public static function export(array $data): never {
  [$where,$params]=self::filters($data);$rows=rows('SELECT e.*,u.name AS expert FROM seo_expert_enquiries e LEFT JOIN users u ON u.id=e.assigned_expert WHERE '.$where.' ORDER BY e.id DESC LIMIT 10001',$params);
  if(count($rows)>10000)fail('Narrow your filters to export at most 10,000 enquiries.');
  audit_log('seo_expert.export',['count'=>count($rows)]);
  header('Content-Type: text/csv; charset=UTF-8');header('Content-Disposition: attachment; filename="seo-expert-enquiries.csv"');
  $columns=['reference','full_name','business_name','website','phone','email','target_location','target_keywords','plan','duration','status','expert','follow_up_at','listed_amount','proposal_amount','payment_status','current_problem','message','created_at'];
  $fp=fopen('php://output','wb');fwrite($fp,"\xEF\xBB\xBF");fputcsv($fp,array_map(fn($k)=>in_array($k,['listed_amount','proposal_amount'])?$k.'_INR':$k,$columns),',','"','');
  foreach($rows as $r){foreach(['listed_amount','proposal_amount'] as $k)$r[$k]=$r[$k]===null?'':number_format((int)$r[$k]/100,2,'.','');fputcsv($fp,array_map(fn($k)=>SeoExpert::csvCell($r[$k]),$columns),',','"','');}fclose($fp);exit;
 }
 public static function chart(string $title,array $values,bool $currency=false): void {
  echo '<section class="card expert-chart"><h3>'.e($title).'</h3>';
  if(!$values){echo '<p>No data yet.</p></section>';return;}$max=max(1,...array_map('abs',array_values($values)));
  echo '<div class="expert-bars">';foreach($values as $label=>$number){$display=$currency?money((int)$number):$number;echo '<div class="expert-bar"><span>'.e($label).'</span><svg viewBox="0 0 100 10" preserveAspectRatio="none" role="img" aria-label="'.e($label.': '.$display).'"><rect width="100" height="10" rx="3" class="expert-track"/><rect width="'.max(0,round(abs($number)/$max*100,2)).'" height="10" rx="3"/></svg><strong>'.e($display).'</strong></div>'; }echo '</div></section>';
 }
}
