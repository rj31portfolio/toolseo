$utf8=New-Object System.Text.UTF8Encoding($false)
function Save($p,$s){[IO.File]::WriteAllText((Join-Path (Get-Location) $p),$s,$utf8)}
$s=Get-Content includes/header.php -Raw
$s=$s.Replace('<!doctype html>',"<?php ob_start(); require ROOT.'/includes/zentro-meta.php'; `$zentroMeta=ob_get_clean(); ?><!doctype html>")
$s=$s.Replace('Audit, monitor and improve your search visibility with one connected SEO workspace. Technical audits, keyword tracking and expert SEO services.','<?=e($description)?>').Replace('Your next SEO win starts here.','<?=e($description)?>').Replace('property="og:type" content="website"','property="og:type" content="<?=e($ogType??''website'')?>"').Replace('/assets/images/favicon.svg','/assets/images/zentro-mark.svg').Replace('</head>','<?=$zentroMeta?></head>')
Save 'includes/header.php' $s
$s=Get-Content includes/footer.php -Raw
$s=$s.Replace('<p>Make every search an opportunity.</p>','<p>Make every search an opportunity.</p><a href="mailto:info@seozentro.com">info@seozentro.com</a><a href="mailto:supports.seozentro@gmail.com">supports.seozentro@gmail.com</a><a href="tel:+918368487667">+91 8368487667</a><?php require ROOT.''/includes/zentro-social.php'';?>')
Save 'includes/footer.php' $s
$s=Get-Content index.php -Raw
$s=$s.Replace("if(`$section==='blog'||", "if(`$section==='contact'){require ROOT.'/public/contact.php';exit;}`nif(`$section==='blog'||")
Save 'index.php' $s
Add-Content admin/settings.php "<?php require ROOT.'/admin/social-settings.php';?>"
