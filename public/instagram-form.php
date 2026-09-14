<?php $instagramService=InstagramDownloader::settings();if($instagramService['enabled']):?>
<section class="section-pad container instagram-tool" id="instagram-downloader" aria-labelledby="instagram-heading">
<div class="section-head"><span class="eyebrow">PUBLIC POSTS &amp; REELS &middot; NO SIGN-UP</span><?php if(($section??'')===''):?><h2 id="instagram-heading"><?=e($instagramService['name'])?></h2><?php else:?><h1 id="instagram-heading"><?=e($instagramService['name'])?></h1><?php endif;?><p><?=e($instagramService['description'])?></p></div>
<div class="instagram-layout"><form id="instagram-form" class="card stack" action="<?=url('/api/v1/instagram-downloader')?>" method="post" data-download-url="<?=url('/api/v1/instagram-media')?>">
<?php csrf_field();?><label for="instagram-url">Public Instagram post or reel URL</label><input id="instagram-url" name="url" type="url" required maxlength="2048" placeholder="https://www.instagram.com/reel/…/" autocomplete="off" spellcheck="false" aria-describedby="instagram-help">
<p class="small" id="instagram-help">Public /p/ and /reel/ links only. No profiles or stories. Instagram may block access even for public posts. Login, CAPTCHA and private-account restrictions are never bypassed.</p>
<button class="button" type="submit">Find available media</button><p id="instagram-status" role="status" aria-live="polite"></p>
<p class="small">Only media exposed in public page metadata can be downloaded, up to 50 MB. Media links expire. Use content you own or have permission to download.</p></form>
<div class="card stack instagram-result" id="instagram-result" aria-busy="false"><p>Paste a public post or reel link to see available media.</p></div></div>
<?php if(($section??'')===''):?><p><a href="<?=url('/'.e($instagramService['slug']))?>">Open the dedicated downloader &rarr;</a></p><?php endif;?>
<noscript><p class="alert">Enable JavaScript to find and download media.</p></noscript></section>
<link rel="stylesheet" href="<?=url('/assets/css/instagram-downloader.css')?>"><script src="<?=url('/assets/js/instagram-downloader.js?v='.filemtime(ROOT.'/assets/js/instagram-downloader.js'))?>" defer></script>
<?php endif;?>
