<?php
$localSeoRoute='/admin/local-seo';
?>
<section class="card stack"><h2>GBP / Local SEO analyzer</h2><form method="get" action="<?=url($localSeoRoute)?>"><label>Website to analyze<select name="website_id" required><option value="">Select a website</option><?php foreach($sites as $site):?><option value="<?=(int)$site['id']?>" <?=$wid===(int)$site['id']?'selected':''?>><?=e($site['name'].' — '.$site['domain'])?></option><?php endforeach;?></select></label><button class="button">Open analyzer</button></form></section>
<?php if($w){require ROOT.'/dashboard/local-seo.php';}else{empty_state('Select a website to begin','Choose a project above, or add a website to your workspace.');} ?>
