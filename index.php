<?php
require __DIR__.'/includes/bootstrap.php';
require ROOT.'/includes/auth.php';
$path=parse_url($_SERVER['REQUEST_URI']??'/',PHP_URL_PATH)?:'/';
$base=base_path(); if($base!=='' && ($path===$base || str_starts_with($path,$base.'/')))$path=substr($path,strlen($base));
if($path==='/index.php')$path='/';
$route='/'.trim($path,'/');$section=trim($route,'/');
if($section==='install'){require ROOT.'/install/index.php';exit;}
if($section==='api/v1/webhook'){require ROOT.'/api/webhook.php';exit;}
if($section==='accept-invitation'){require ROOT.'/auth/invitation.php';exit;}
if($section==='invoice'){Invoice::show((int)($_GET['id']??0));}
if(!isset($_SESSION['user_id']) && isset($_COOKIE['seo_remember']) && is_file(ROOT.'/storage/installed.lock')) {
 db()->beginTransaction();$t=row("SELECT * FROM auth_tokens WHERE token_hash=? AND purpose='remember' AND expires_at>NOW() FOR UPDATE",[hash('sha256',$_COOKIE['seo_remember'])]);
 if($t){query('DELETE FROM auth_tokens WHERE id=?',[$t['id']]);session_regenerate_id(true);$_SESSION['user_id']=$t['user_id'];$_SESSION['session_version']=(int)value('SELECT session_version FROM users WHERE id=?',[$t['user_id']]);$new=auth_token((int)$t['user_id'],'remember',720);setcookie('seo_remember',$new,['expires'=>time()+2592000,'path'=>base_path()?:'/','secure'=>str_starts_with(cfg('APP_URL'),'https://'),'httponly'=>true,'samesite'=>'Lax']);}db()->commit();
}
if(setting('maintenance',false) && !is_admin() && !in_array($section,['login','logout']))fail('Scheduled maintenance is in progress. Please return shortly.',503);
if(str_starts_with($section,'api/v1/')){require ROOT.'/api/router.php';exit;}
if(in_array($section,['login','register','forgot-password','reset-password','verify-email','logout'])){if($_SERVER['REQUEST_METHOD']==='POST')auth_action($section);if($section==='logout')fail('Use the sign-out button.',405);$route=$section;require ROOT.'/auth/page.php';exit;}
if($section===''){require ROOT.'/public/home.php';exit;}
if(in_array($section,['features','pricing','how-it-works','seo-tools','about','contact','blog','terms','privacy','refund-policy','cookie-policy'])){require ROOT.'/public/page.php';exit;}
if($section==='sitemap.xml'){header('Content-Type: application/xml');echo '<?xml version="1.0" encoding="UTF-8"?><urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';foreach(['','features','pricing','how-it-works','seo-tools','about','contact','blog','terms','privacy','refund-policy'] as $p)echo '<url><loc>'.e(cfg('APP_URL').'/'.$p).'</loc></url>';echo '</urlset>';exit;}
if(str_starts_with($section,'admin')){require ROOT.'/admin/index.php';exit;}
$modules=['local-seo','sitemap-generator','robots-generator','services','dashboard','websites','website','audit','pages','keywords','rankings','research','competitors','backlinks','content','tasks','reports','report','ai-assistant','schema','internal-links','automations','human-services','team','billing','profile','notifications','subscription','project-settings'];
if(isset(WorkspaceUI::utilities()[$section])){$localTool=substr($section,6);$section='no-api-tools';require ROOT.'/dashboard/index.php';exit;}
if($section==='no-api-tools'){$section='services';}
if(in_array($section,$modules)){require ROOT.'/dashboard/index.php';exit;}
fail('We couldn’t find that page.',404);
