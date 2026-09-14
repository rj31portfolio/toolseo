<?php
$user=require_user();$action=substr($section,7);$method=$_SERVER['REQUEST_METHOD'];
if($method==='GET'){
 if($action==='local-seo-pdf'){$w=website((int)($_GET['website_id']??0));if(!LocalSeoAudit::ready())fail('Local SEO storage is not installed.',503);$audit=LocalSeoAudit::get((int)$w['id'],(int)($_GET['audit_id']??0));rate_limit('local-seo-pdf:'.$user['id'],20,60);session_write_close();set_time_limit(90);LocalSeoAudit::pdf($audit);}
 if($action==='crawl-progress'){$w=website((int)($_GET['website_id']??0));$job=row('SELECT * FROM crawl_jobs WHERE website_id=? ORDER BY id DESC LIMIT 1',[$w['id']]);json_response($job??[],'Crawl progress');}
 if($action==='notifications')json_response(rows('SELECT * FROM notifications WHERE user_id=? ORDER BY id DESC LIMIT 30',[$user['id']]));
 if($action==='export'){require ROOT.'/api/export.php';exit;}
 fail('Unknown endpoint.',404);
}
if($method!=='POST')fail('Method not allowed.',405);check_csrf();rate_limit('api:'.$user['id'],120,60);
if(setting('require_verification',false) && !$user['verified_at'])fail('Verify your email before making changes.',403);
if(str_starts_with($action,'chat/')){require ROOT.'/api/chat-manage.php';exit;}
if($action==='website'){
 if($user['role']==='team_member')fail('Team members cannot create projects.',403);
 try{$domain=SafeHttp::normalize(required_input('domain',500));SafeHttp::resolve(parse_url($domain,PHP_URL_HOST));}catch(Throwable $e){fail($e->getMessage());}
 $domain=rtrim(parse_url($domain,PHP_URL_SCHEME).'://'.parse_url($domain,PHP_URL_HOST),'/').'/';
 db()->beginTransaction();query('SELECT id FROM users WHERE id=? FOR UPDATE',[$user['id']]);limit_check((int)$user['id'],'websites',(int)value('SELECT COUNT(*) FROM websites WHERE user_id=?',[$user['id']]));
 if(value('SELECT id FROM websites WHERE user_id=? AND domain_hash=?',[$user['id'],hash('sha256',preg_replace('~^https?://~','',$domain))]))fail('This website is already in your workspace.');
 $tz=input('timezone',60,'UTC');if(!in_array($tz,DateTimeZone::listIdentifiers()))fail('Invalid timezone.');query('INSERT INTO websites(user_id,name,domain,domain_hash,country,language,search_engine,timezone) VALUES (?,?,?,?,?,?,?,?)',[$user['id'],required_input('name',120),$domain,hash('sha256',preg_replace('~^https?://~','',$domain)),input('country',80,'India'),input('language',40,'en'),enum_input('search_engine',['google','bing'],'google'),$tz]);$id=db()->lastInsertId();audit_log('website.created',['id'=>$id]);db()->commit();json_response(['redirect'=>url('/dashboard?website_id='.$id)],'Website added');
}
if($action==='profile'){
 $name=required_input('name',120);$tz=input('timezone',60,'UTC');if(!in_array($tz,DateTimeZone::listIdentifiers()))fail('Invalid timezone.');
 if(input('new_password',200)!==''){if(!password_verify(input('current_password',200),$user['password']))fail('Current password is incorrect.');$p=input('new_password',200);if(strlen($p)<12)fail('New password needs at least 12 characters.');query('UPDATE users SET password=?,session_version=session_version+1 WHERE id=?',[password_hash($p,PASSWORD_DEFAULT),$user['id']]);query("DELETE FROM auth_tokens WHERE user_id=? AND purpose='remember'",[$user['id']]);session_regenerate_id(true);$_SESSION['session_version']=(int)$user['session_version']+1;}
 query('UPDATE users SET name=?,company=?,phone=?,timezone=?,country=?,notification_email=? WHERE id=?',[$name,input('company',190),input('phone',40),$tz,input('country',80),isset($_POST['notification_email'])?1:0,$user['id']]);audit_log('profile.updated');json_response([],'Profile updated');
}
if($action==='notification-read'){query('UPDATE notifications SET read_at=NOW() WHERE user_id=? AND id=?',[$user['id'],(int)($_POST['id']??0)]);json_response();}
if($action==='checkout'){Payment::checkout($user);}
if($action==='extra-checkout'){ExtrasCheckout::create($user);}
if($action==='cancel-subscription'){query("UPDATE subscriptions SET status='cancelled',cancelled_at=NOW() WHERE user_id=? AND status='active' AND plan_id<>(SELECT id FROM plans WHERE slug='free')",[$user['id']]);audit_log('subscription.cancelled');json_response([],'Subscription cancelled. Your account now uses Free plan limits.');}
if(str_starts_with($action,'admin/')){require ROOT.'/api/admin.php';exit;}
$w=website((int)($_POST['website_id']??0));
if($action==='local-seo-audit'){$profile=LocalSeo::validate($_POST);$id=LocalSeoAudit::save($w,$profile);json_response(['id'=>$id,'redirect'=>url((is_admin($user)&&input('admin_context',1)==='1'?'/admin/local-seo':'/local-seo').'?website_id='.$w['id'].'&audit_id='.$id.'#local-seo-results')],'Local SEO audit saved.');}
if($action==='local-seo-schema'){json_response(['reply'=>LocalSeo::schema(LocalSeo::validate($_POST))],'LocalBusiness schema draft ready.');}
if($action==='generate-sitemap'){$result=SeoFiles::sitemap($w['domain'],required_input('urls',500000),input('lastmod',10));json_response($result,'Sitemap ready: '.$result['count'].' unique URLs.');}
if($action==='generate-robots'){json_response(SeoFiles::robots(required_input('agents',2000),input('disallow',30000),input('allow',30000),input('sitemaps',30000)),'Robots.txt ready to review and download.');}
if($action==='ranking-check'){
 owned_website((int)$w['id']);
 if(!cfg('RANKING_ENDPOINT')||!cfg('RANKING_API_KEY'))fail('Connect your ranking provider in Administration > Settings.',503);
 $keyword=row('SELECT k.*,w.domain FROM keywords k JOIN websites w ON w.id=k.website_id WHERE k.id=? AND k.website_id=?',[(int)($_POST['keyword_id']??0),$w['id']]);
 if(!$keyword)fail('Keyword not found in this website.',404);
 session_write_close();set_time_limit(960);
 try{$ranking=Ranking::check($keyword);}catch(RuntimeException $e){fail($e->getMessage(),503);}
 json_response($ranking,'Ranking saved');
}
require ROOT.'/api/insights.php';
require ROOT.'/api/extended.php';
if($action==='save'){json_response(['id'=>Modules::save(input('module',50),$w)],'Saved successfully');}
if($action==='delete'){$def=Modules::definitions()[input('module',50)]??null;if(!$def)fail('Invalid module.');owned_website((int)$w['id']);query('DELETE FROM '.$def['table'].' WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);audit_log('record.deleted',['module'=>input('module',50)]);json_response();}
if($action==='crawl'){owned_website((int)$w['id']);json_response(['job_id'=>Crawler::start($w),'redirect'=>url('/audit?website_id='.$w['id'])],'Audit started.');}
if($action==='crawl-step'){
 owned_website((int)$w['id']);
 $job=row('SELECT * FROM crawl_jobs WHERE website_id=? ORDER BY id DESC LIMIT 1',[$w['id']]);
 if(!$job)fail('Start an audit first.',404);
 // Release the session so navigation and progress requests remain responsive.
 session_write_close();set_time_limit(300);
 if(in_array($job['status'],['queued','running'],true))Crawler::work((int)$job['id'],1);
 json_response(row('SELECT * FROM crawl_jobs WHERE id=?',[$job['id']]),'Audit progress');
}
if($action==='audit'){owned_website((int)$w['id']);$j=row("SELECT id FROM crawl_jobs WHERE website_id=? AND status='completed' ORDER BY id DESC LIMIT 1",[$w['id']]);if(!$j)fail('Complete a crawl first.');json_response(['audit_id'=>Audit::run((int)$j['id'])]);}
if($action==='issue-task'){$i=row('SELECT * FROM seo_issues WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);if(!$i)fail('Issue not found.',404);query('INSERT IGNORE INTO seo_tasks(website_id,title,url,issue_id,priority,notes) VALUES (?,?,?,?,?,?)',[$w['id'],$i['title'],$i['url'],$i['id'],in_array($i['severity'],['critical','high','medium','low'])?$i['severity']:'low',$i['recommendation']]);json_response([],'Task created');}
if($action==='issue-status'){query('UPDATE seo_issues SET status=? WHERE id=? AND website_id=?',[enum_input('status',['open','resolved','ignored']),(int)($_POST['id']??0),$w['id']]);json_response();}
if($action==='task-status'){query('UPDATE seo_tasks SET status=? WHERE id=? AND website_id=?',[enum_input('status',['open','in_progress','waiting','completed','rejected']),(int)($_POST['id']??0),$w['id']]);json_response();}
if($action==='assign-task'){owned_website((int)$w['id']);$uid=(int)($_POST['assigned_user']??0);if($uid && $uid!=(int)$w['user_id'] && !value('SELECT id FROM team_members WHERE user_id=? AND website_id=?',[$uid,$w['id']]))fail('Assignee must belong to this project.');query('UPDATE seo_tasks SET assigned_user=? WHERE id=? AND website_id=?',[$uid?:null,(int)($_POST['id']??0),$w['id']]);if($uid)notify($uid,'An SEO task has been assigned to you.','/tasks?website_id='.$w['id']);json_response();}
if($action==='import'){require ROOT.'/api/import.php';exit;}
if($action==='ai-write'){json_response(['reply'=>AI::chat($w,AIWriting::prompt())],'Draft generated and saved to your AI history.');}
if($action==='ai'){json_response(['reply'=>AI::chat($w,required_input('message',6000))],'Response ready');}
if($action==='content-brief'){$p=row('SELECT * FROM content_projects WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);if(!$p)fail('Content project not found.',404);$reply=AI::chat($w,'Create a content brief with title ideas, H1/H2 outline, FAQ questions, meta description and internal-link suggestions. Topic: '.$p['topic'].'. Keyword: '.$p['keyword'].'. Audience: '.$p['audience'].'. Country: '.$p['country'].'. Language: '.$p['language']);query("INSERT INTO content_briefs(content_project_id,content,source) VALUES (?,?,'ai')",[$p['id'],$reply]);json_response(['reply'=>$reply]);}
if($action==='save-brief'){$p=row('SELECT id FROM content_projects WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);if(!$p)fail('Content project not found.',404);query("INSERT INTO content_briefs(content_project_id,content,source) VALUES (?,?,'manual')",[$p['id'],required_input('content',60000)]);json_response();}
if($action==='report'){$id=Report::create($w,$user);json_response(['redirect'=>url('/report?id='.$id.'&website_id='.$w['id'])],'Report generated');}
if($action==='email-report'){owned_website((int)$w['id']);$r=row('SELECT * FROM reports WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);if(!$r)fail('Report not found.',404);email_queue($user['email'],'Your SEO report is ready',cfg('APP_URL').'/report?id='.$r['id'].'&website_id='.$w['id']);json_response([],'Report link queued for delivery to your account email.');}
if($action==='schema'){json_response(['json'=>Schema::generate(enum_input('type',Schema::types()),required_input('json',30000))],'JSON-LD is ready. Review it before publishing.');}
if($action==='automation'){owned_website((int)$w['id']);$code=enum_input('code',['missing_description','long_title','http_error','sitemap']);query('INSERT INTO automation_rules(website_id,code,enabled) VALUES (?,?,?) ON DUPLICATE KEY UPDATE enabled=VALUES(enabled)',[$w['id'],$code,(int)isset($_POST['enabled'])]);json_response();}
if($action==='link-status'){query('UPDATE internal_link_suggestions SET status=? WHERE id=? AND website_id=?',[enum_input('status',['accepted','rejected','implemented']),(int)($_POST['id']??0),$w['id']]);json_response();}
if($action==='find-links'){InternalLinks::generate($w);json_response([],'Suggestions generated from your latest crawl.');}
if($action==='team'){owned_website((int)$w['id']);$member=row('SELECT id FROM users WHERE email=? AND active=1',[strtolower(required_input('email',190))]);if(!$member)fail('Ask the team member to register first, then assign their email here.');if($member['id']==$w['user_id'])fail('The owner already has access.');db()->beginTransaction();query('SELECT id FROM users WHERE id=? FOR UPDATE',[$w['user_id']]);limit_check((int)$w['user_id'],'team_members',(int)value('SELECT COUNT(DISTINCT user_id) FROM team_members WHERE owner_id=?',[$w['user_id']]));query('INSERT IGNORE INTO team_members(owner_id,user_id,website_id) VALUES (?,?,?)',[$w['user_id'],$member['id'],$w['id']]);db()->commit();notify((int)$member['id'],'You have been assigned to '.$w['name'],'/dashboard?website_id='.$w['id']);json_response();}
if($action==='team-remove'){owned_website((int)$w['id']);query('DELETE FROM team_members WHERE id=? AND website_id=?',[(int)($_POST['id']??0),$w['id']]);json_response();}
if($action==='branding'){owned_website((int)$w['id']);if(!plan((int)$w['user_id'])['white_label'])fail('White-label reporting requires an Agency plan.');$data=[];foreach(['agency_name','agency_website','agency_contact','report_footer','brand_color','logo_url'] as $key){$v=input($key,500);if(in_array($key,['agency_website','logo_url'])&&$v!=='')try{$v=SafeHttp::normalize($v);}catch(Throwable $e){fail($e->getMessage());}if($key==='brand_color'&&!preg_match('/^#[0-9a-f]{6}$/i',$v))fail('Use a six-digit hex color.');$data[$key]=$v;}$data['logo_data']=$data['logo_url']?Branding::logo($data['logo_url']):'';db()->beginTransaction();foreach($data as $key=>$v)query('INSERT INTO website_settings(website_id,name,value) VALUES (?,?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)',[$w['id'],$key,$v]);db()->commit();json_response();}
fail('Unknown endpoint.',404);
