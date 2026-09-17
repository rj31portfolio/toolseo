$utf8 = New-Object System.Text.UTF8Encoding($false)
function Save($path,$content){[IO.File]::WriteAllText((Join-Path (Get-Location) $path),$content,$utf8)}
$files = rg -l 'SEO AutoPilot|SEO AUTOPILOT|SEO<span>AutoPilot' public includes admin auth dashboard config/config.example.php
foreach($file in $files){$s=[IO.File]::ReadAllText((Join-Path (Get-Location) $file));$s=$s.Replace('SEO AutoPilot','SEO Zentro').Replace('SEO AUTOPILOT','SEO ZENTRO').Replace('SEO<span>AutoPilot</span>','SEO <span>Zentro</span>');Save $file $s}
$s=Get-Content index.php -Raw
$s=$s.Replace("require ROOT.'/public/home.php'","require ROOT.'/public/zentro-home.php'")
$s=$s.Replace("if(`$section===''){", "if(`$section==='blog'||str_starts_with(`$section,'blog/')){require ROOT.'/public/blog.php';exit;}`nif(in_array(`$section,['google-maps-leads','yelp-leads','yellow-pages-leads'],true)){require ROOT.'/public/lead-service.php';exit;}`nif(`$section===''){")
$s=$s.Replace("if(`$section==='sitemap.xml'){", "if(`$section==='robots.txt'){header('Content-Type: text/plain');echo 'User-agent: *'.PHP_EOL.'Disallow: '.url('/admin').PHP_EOL.'Disallow: '.url('/api/').PHP_EOL.'Sitemap: '.rtrim(cfg('APP_URL'),'/').'/sitemap.xml';exit;}`nif(`$section==='sitemap.xml'){")
$s=$s.Replace("foreach(['','hire-seo-expert'", "foreach(array_merge(array_map(static fn(`$p)=>'blog/'.`$p['slug'],Launch::posts()),['google-maps-leads','yelp-leads','yellow-pages-leads','','hire-seo-expert'")
$s=$s.Replace("'refund-policy'] as `$p)","'refund-policy']) as `$p)")
Save 'index.php' $s
$s=Get-Content admin/index.php -Raw
$s=$s.Replace("`$tabs=['seo-expert'", "`$tabs=['google-maps-leads'=>'Google Maps Leads','yelp-leads'=>'Yelp Leads','yellow-pages-leads'=>'Yellow Pages Leads','blog'=>'Blog','seo-expert'")
$s=$s.Replace("if(`$tab==='seo-expert'):","if(in_array(`$tab,['google-maps-leads','yelp-leads','yellow-pages-leads'],true)):require ROOT.'/admin/business-leads.php';elseif(`$tab==='blog'):require ROOT.'/admin/blog.php';elseif(`$tab==='seo-expert'):")
Save 'admin/index.php' $s
$s=Get-Content api/admin.php -Raw
$s=$s.Replace("if(`$op==='chat-install')", "if(in_array(`$op,['blog-save','social-save','lead-search','lead-export'],true)){require ROOT.'/api/launch.php';exit;}`nif(`$op==='chat-install')")
Save 'api/admin.php' $s
$s=Get-Content includes/BusinessLeads.php -Raw
$s=$s.Replace("`$data['localResults']??", "`$data['organicResults']??`$data['localResults']??")
Save 'includes/BusinessLeads.php' $s
$s=Get-Content config/config.example.php -Raw
$s=$s.Replace("'RANKING_ENDPOINT'=>'',", "'LEADS_API_KEY'=>'', 'RANKING_ENDPOINT'=>'',")
Save 'config/config.example.php' $s
$s=Get-Content public/pricing-cards.php -Raw
$s=$s.Replace("url('/register')", "url(current_user()?'/billing':'/register')")
Save 'public/pricing-cards.php' $s
