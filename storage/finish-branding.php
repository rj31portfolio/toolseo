<?php
require dirname(__DIR__).'/includes/bootstrap.php';
$files=explode("\n",trim(shell_exec('git diff --name-only')));
foreach($files as $file){
 if(!str_ends_with($file,'.php')||$file==='includes/BusinessLeads.php')continue;
 $s=shell_exec('git show HEAD:'.escapeshellarg($file));if(!$s)continue;
 $s=str_replace(['SEO AutoPilot','SEO AUTOPILOT','SEO<span>AutoPilot</span>'],['SEO Zentro','SEO ZENTRO','SEO <span>Zentro</span>'],$s);
 if($file==='index.php'){
  $s=str_replace("require ROOT.'/public/home.php'","require ROOT.'/public/zentro-home.php'",$s);
  $s=str_replace("if(\$section===''){", "if(\$section==='contact'){require ROOT.'/public/contact.php';exit;}\nif(\$section==='blog'||str_starts_with(\$section,'blog/')){require ROOT.'/public/blog.php';exit;}\nif(in_array(\$section,['google-maps-leads','yelp-leads','yellow-pages-leads'],true)){require ROOT.'/public/lead-service.php';exit;}\nif(\$section===''){",$s);
  $s=str_replace("if(\$section==='sitemap.xml'){", "if(\$section==='robots.txt'){header('Content-Type: text/plain');echo 'User-agent: *'.PHP_EOL.'Disallow: '.url('/admin').PHP_EOL.'Disallow: '.url('/api/').PHP_EOL.'Disallow: '.url('/dashboard').PHP_EOL.'Sitemap: '.rtrim(cfg('APP_URL'),'/').'/sitemap.xml';exit;}\nif(\$section==='sitemap.xml'){",$s);
  $s=str_replace("foreach(['','hire-seo-expert'","foreach(array_merge(array_map(static fn(\$p)=>'blog/'.\$p['slug'],Launch::posts()),['google-maps-leads','yelp-leads','yellow-pages-leads','','hire-seo-expert'",$s);
  $s=str_replace("'refund-policy'] as \$p)","'refund-policy']) as \$p)",$s);
 }
 if($file==='admin/index.php'){
  $s=str_replace("\$tabs=['seo-expert'","\$tabs=['google-maps-leads'=>'Google Maps Leads','yelp-leads'=>'Yelp Leads','yellow-pages-leads'=>'Yellow Pages Leads','blog'=>'Blog','seo-expert'",$s);
  $s=str_replace("if(\$tab==='seo-expert'):","if(in_array(\$tab,['google-maps-leads','yelp-leads','yellow-pages-leads'],true)):require ROOT.'/admin/business-leads.php';elseif(\$tab==='blog'):require ROOT.'/admin/blog.php';elseif(\$tab==='seo-expert'):",$s);
 }
 if($file==='api/admin.php')$s=str_replace("if(\$op==='chat-install')","if(in_array(\$op,['blog-save','social-save','lead-search','lead-export'],true)){require ROOT.'/api/launch.php';exit;}\nif(\$op==='chat-install')",$s);
 if($file==='config/config.example.php')$s=str_replace("'RANKING_ENDPOINT'=>'',","'LEADS_API_KEY'=>'', 'RANKING_ENDPOINT'=>'',",$s);
 if($file==='public/pricing-cards.php')$s=str_replace("url('/register')","url(current_user()?'/billing':'/register')",$s);
 if($file==='includes/header.php'){
  $s="<?php ob_start(); require ROOT.'/includes/zentro-meta.php'; \$zentroMeta=ob_get_clean(); ?>".$s;
  $s=str_replace(['Audit, monitor and improve your search visibility with one connected SEO workspace. Technical audits, keyword tracking and expert SEO services.','Your next SEO win starts here.'],['<?=e($description)?>','<?=e($description)?>'],$s);
  $s=str_replace(['property="og:type" content="website"','/assets/images/favicon.svg','</head>'],['property="og:type" content="<?=e($ogType??\'website\')?>"','/assets/images/zentro-mark.svg','<?=$zentroMeta?></head>'],$s);
 }
 if($file==='includes/footer.php')$s=str_replace('<p>Make every search an opportunity.</p>','<p>Make every search an opportunity.</p><a href="mailto:info@seozentro.com">info@seozentro.com</a><a href="mailto:supports.seozentro@gmail.com">supports.seozentro@gmail.com</a><a href="tel:+918368487667">+91 8368487667</a><?php require ROOT.\'/includes/zentro-social.php\';?>',$s);
 if($file==='admin/settings.php')$s.="\n<?php require ROOT.'/admin/social-settings.php';?>\n";
 file_put_contents(ROOT.'/'.$file,$s);
}
foreach(['admin/b2b-leads.php','admin/advanced.php'] as $file){$s=file_get_contents(ROOT.'/'.$file);$s=str_replace(['HasData / gateway','HasData credits','Connect HasData'],['data service / gateway','lead search credits','Connect the lead search service'],$s);file_put_contents(ROOT.'/'.$file,$s);}
echo "Branding and routes updated with UTF-8 preserved.\n";
foreach(['APP_URL','LEADS_API_KEY','RANKING_API_KEY','RAZORPAY_KEY','RAZORPAY_SECRET','RAZORPAY_WEBHOOK_SECRET','SMTP_HOST','SMTP_FROM'] as $k)echo $k.': '.($k==='APP_URL'?cfg($k):(cfg($k)?'configured':'missing')).PHP_EOL;
