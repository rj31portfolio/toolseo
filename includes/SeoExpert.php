<?php
final class SeoExpert {
 public const STATUSES=['New','Contacted','Audit','Proposal','Payment Pending','Active','Completed','Lost'];
 public const PLANS=['starter'=>'Starter','growth'=>'Growth','pro'=>'Pro'];
 public const DURATIONS=[3=>'3 Months',6=>'6 Months',12=>'1 Year'];
 public static function prices(): array {return [3=>['starter'=>4999,'growth'=>7999,'pro'=>11999],6=>['starter'=>8999,'growth'=>14999,'pro'=>21999],12=>['starter'=>15999,'growth'=>27999,'pro'=>39999]];}
 public static function price(string $plan,int $months): int {if(!isset(self::prices()[$months][$plan]))throw new InvalidArgumentException('Choose a valid SEO plan and duration.');return self::prices()[$months][$plan]*100;}
 public static function savings(string $plan,int $months): array {$price=self::price($plan,$months);$baseline=self::price($plan,3)*($months/3);return ['total'=>$baseline-$price,'monthly'=>($baseline-$price)/$months,'percent'=>$baseline?round(($baseline-$price)/$baseline*100):0];}
 public static function ready(): bool {return (bool)value("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='seo_expert_payments'");}
 public static function migrate(): void {foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents(ROOT.'/database/migrations/008-seo-expert.sql')) as $sql)if(trim($sql)!=='')query($sql);}
 public static function website(string $input,bool $optional=false): string {
  if($optional&&trim($input)==='')return '';
  try{$url=SafeHttp::normalize($input);}catch(Throwable){throw new InvalidArgumentException('Enter a full public website URL beginning with https:// or http://.');}
  $host=parse_url($url,PHP_URL_HOST);
  if(!preg_match('/^(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,63}$/i',$host)||preg_match('/\.(local|localhost|internal|invalid|test)$/i',$host)||filter_var($host,FILTER_VALIDATE_IP))throw new InvalidArgumentException('Enter a public website domain.');
  return $url;
 }
 public static function fields(array $data): array {
  $result=[];foreach(['full_name'=>120,'business_name'=>190,'website'=>500,'phone'=>40,'email'=>190,'target_location'=>190,'target_keywords'=>3000,'current_problem'=>3000,'message'=>5000] as $key=>$max){$v=$data[$key]??'';if(!is_string($v)||mb_strlen($v)>$max)throw new InvalidArgumentException('Invalid '.str_replace('_',' ',$key).'.');$v=trim($v);if($v===''&&$key!=='message')throw new InvalidArgumentException(ucfirst(str_replace('_',' ',$key)).' is required.');$result[$key]=$v;}
  if(!filter_var($result['email'],FILTER_VALIDATE_EMAIL))throw new InvalidArgumentException('Enter a valid email address.');
  $digits=preg_replace('/\D/','',$result['phone']);if(!preg_match('/^\+?[0-9 ()\-.]+$/D',$result['phone'])||strlen($digits)<7||strlen($digits)>15)throw new InvalidArgumentException('Enter a phone number with 7 to 15 digits, including country code.');
  $result['website']=self::website($result['website']);$plan=$data['plan']??'undecided';$duration=$data['duration']??'3';
  if(!is_string($plan)||!in_array($plan,array_merge(['undecided'],array_keys(self::PLANS)),true)||!in_array((string)$duration,['3','6','12'],true))throw new InvalidArgumentException('Choose a valid plan and duration.');
  $result['plan']=$plan;$result['duration']=(int)$duration;$result['listed_amount']=$plan==='undecided'?0:self::price($plan,(int)$duration);return $result;
 }
 public static function amount(string $value,bool $optional=false): ?int {
  if($optional&&$value==='')return null;if(!preg_match('/^(?:0|[1-9][0-9]{0,7})(?:\.[0-9]{1,2})?$/D',$value))throw new InvalidArgumentException('Enter a valid rupee amount with up to two decimals.');$parts=explode('.',$value);$minor=(int)$parts[0]*100+(int)str_pad($parts[1]??'',2,'0');if($minor>1000000000)throw new InvalidArgumentException('The maximum amount is ₹10,000,000.');return $minor;
 }
 public static function date(string $value,bool $optional=false,bool $time=false): ?string {
  if($optional&&$value==='')return null;$format=$time?'Y-m-d\TH:i':'Y-m-d';$date=DateTimeImmutable::createFromFormat('!'.$format,$value);if(!$date||$date->format($format)!==$value)throw new InvalidArgumentException('Enter a valid '.($time?'date and time':'date').'.');return $date->format($time?'Y-m-d H:i:s':'Y-m-d');
 }
 public static function endDate(string $start,int $months): string {
  self::date($start);if(!isset(self::DURATIONS[$months]))throw new InvalidArgumentException('Invalid program duration.');$date=new DateTimeImmutable($start);$target=$date->modify('first day of this month')->modify('+'.$months.' months');$day=min((int)$date->format('d'),(int)$target->format('t'));return $target->setDate((int)$target->format('Y'),(int)$target->format('m'),$day)->modify('-1 day')->format('Y-m-d');
 }
 public static function expert(string $id): ?int {
  if($id===''||$id==='0')return null;if(!ctype_digit($id)||!value("SELECT id FROM users WHERE id=? AND active=1 AND role IN ('admin','super_admin','team_member')",[(int)$id]))fail('Choose an active SEO expert or administrator.');return (int)$id;
 }
 public static function enquiry(int $id,bool $lock=false): array {$e=row('SELECT * FROM seo_expert_enquiries WHERE id=?'.($lock?' FOR UPDATE':''),[$id]);if(!$e)fail('Enquiry not found.',404);return $e;}
 public static function client(int $id): array {$c=row('SELECT c.*,e.full_name,e.business_name,e.email,e.phone,e.reference FROM seo_expert_clients c JOIN seo_expert_enquiries e ON e.id=c.enquiry_id WHERE c.id=?',[$id]);if(!$c)fail('SEO client not found.',404);return $c;}
 public static function activate(array $lead): ?int {
  $existing=row('SELECT * FROM seo_expert_clients WHERE enquiry_id=?',[$lead['id']]);
  if(!in_array($lead['status'],['Active','Completed'],true)){if($existing)query("UPDATE seo_expert_clients SET status='On Hold' WHERE id=?",[$existing['id']]);return $existing?(int)$existing['id']:null;}
  if($lead['plan']==='undecided')fail('Choose Starter, Growth or Pro before activating a client.');
  if($existing){query('UPDATE seo_expert_clients SET status=? WHERE id=?',[$lead['status'],$existing['id']]);return (int)$existing['id'];}
  $start=date('Y-m-d');$end=self::endDate($start,(int)$lead['duration']);query('INSERT INTO seo_expert_clients(enquiry_id,website,plan,duration,start_date,end_date,assigned_expert,target_keywords,target_location,notes,status) VALUES (?,?,?,?,?,?,?,?,?,\'\',?)',[$lead['id'],$lead['website'],$lead['plan'],$lead['duration'],$start,$end,$lead['assigned_expert'],$lead['target_keywords'],$lead['target_location'],$lead['status']]);$id=(int)db()->lastInsertId();
  foreach(['Audit & Fix','Optimize & Grow','Scale & Improve'] as $i=>$title){$due=min($end,date('Y-m-d',strtotime($start.' +'.(($i+1)*30-1).' days')));query('INSERT INTO seo_expert_tasks(client_id,month_number,title,due_date) VALUES (?,?,?,?)',[$id,$i+1,$title,$due]);}return $id;
 }
 public static function paymentSummary(array $lead): array {
  $p=row("SELECT COALESCE(SUM(CASE WHEN status='paid' AND kind='payment' THEN amount ELSE 0 END),0) AS received,COALESCE(SUM(CASE WHEN status='paid' AND kind='refund' THEN amount ELSE 0 END),0) AS refunded,COALESCE(SUM(status='pending'),0) AS pending,COALESCE(SUM(status='failed'),0) AS failed FROM seo_expert_payments WHERE enquiry_id=?",[$lead['id']]);$net=(int)$p['received']-(int)$p['refunded'];$due=(int)($lead['proposal_amount']??$lead['listed_amount']);
  $state=$net>0?($due>0&&$net>=$due?'Paid':'Partial'):((int)$p['refunded']>0?'Refunded':((int)$p['pending']>0?'Pending':((int)$p['failed']>0?'Failed':'Unpaid')));
  return ['net'=>$net,'received'=>(int)$p['received'],'refunded'=>(int)$p['refunded'],'due'=>$due,'balance'=>max(0,$due-$net),'status'=>$state];
 }
 public static function syncPayment(int $id): void {$lead=self::enquiry($id);$summary=self::paymentSummary($lead);if($summary['net']<0)fail('Paid refunds cannot exceed received payments for this enquiry.');query('UPDATE seo_expert_enquiries SET payment_status=? WHERE id=?',[$summary['status'],$id]);}
 public static function schema(): array {
  $offers=[];foreach(self::DURATIONS as $months=>$label)foreach(self::PLANS as $key=>$name)$offers[]=['@type'=>'Offer','name'=>$name.' · '.$label,'price'=>self::price($key,$months)/100,'priceCurrency'=>'INR','url'=>rtrim(cfg('APP_URL'),'/').'/hire-seo-expert?plan='.$key.'&duration='.$months.'&enquire=1','itemOffered'=>['@type'=>'Service','name'=>$name.' SEO Growth Program — '.$label]];
  return ['@context'=>'https://schema.org','@type'=>'Service','name'=>'Hire an SEO Expert','serviceType'=>'SEO strategy and optimization','description'=>'Dedicated SEO expertise, customized strategy, technical optimization, content planning and monthly progress tracking.','url'=>rtrim(cfg('APP_URL'),'/').'/hire-seo-expert','hasOfferCatalog'=>['@type'=>'OfferCatalog','name'=>'SEO Growth Programs','itemListElement'=>$offers]];
 }
 public static function csvCell(mixed $value): string {$text=(string)($value??'');return preg_match('/^[\s\x00-\x1f]*[=+@-]/u',$text)?"'".$text:$text;}
}
