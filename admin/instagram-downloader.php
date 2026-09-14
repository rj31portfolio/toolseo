<?php $service=InstagramDownloader::settings();?>
<section class="card stack"><h2>Instagram Post &amp; Reel Downloader</h2><p>Public page metadata only. No external API, login or access-control bypass.</p><form data-api="admin/instagram-service"><div class="form-grid">
<?php field('name','Service name','text',$service['name']);field('slug','Page slug','text',$service['slug']);?>
<label>Description<textarea name="description" maxlength="1000" required><?=e($service['description'])?></textarea></label>
<?php select_field('enabled','Availability',['1'=>'Enabled','0'=>'Disabled'],$service['enabled']?'1':'0');select_field('visible','Home & directory visibility',['1'=>'Visible','0'=>'Hidden (direct link still works)'],$service['visible']?'1':'0');?></div>
<p class="small">Disabling blocks the page, metadata lookup and download. Changing the slug changes the public URL.</p><button class="button">Save service settings</button><?php if($service['enabled']):?> <a class="button secondary" href="<?=url('/'.e($service['slug']))?>">Open public tool</a><?php endif;?></form></section>
