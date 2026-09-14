<?php $domainService=DomainDns::settings(); if($domainService['enabled']): ?>
<section class="section-pad container domain-dns" id="domain-dns-checker" aria-labelledby="domain-dns-heading">
<div class="section-head"><span class="eyebrow">FREE TOOL &middot; NO SIGN-UP</span><h2 id="domain-dns-heading"><?=e($domainService['name'])?></h2><p><?=e($domainService['description'])?></p></div>
<form id="domain-dns-form" class="card stack" action="<?=url('/api/v1/domain-dns')?>" method="post">
<?php csrf_field(); ?><label for="domain-dns-input">Domain name</label><div class="domain-dns-entry"><input id="domain-dns-input" name="domain" placeholder="example.com" required maxlength="253" autocomplete="off" autocapitalize="none" spellcheck="false" aria-describedby="domain-dns-help"><button class="button" type="submit">Check domain &amp; DNS</button></div>
<p class="small" id="domain-dns-help">Enter a domain without https:// or a path. DNS checks the exact name; for registration details, enter the registered domain. International domains can use their xn-- form.</p>
<p class="small">Public RDAP data may hide or omit owner details and dates. A lookup does not verify that you own a domain. DNS answers reflect Google Public DNS at lookup time.</p>
<p id="domain-dns-status" role="status" aria-live="polite"></p></form>
<div id="domain-dns-results" class="domain-dns-results" aria-busy="false" hidden></div>
<p class="small">Sources: <a href="https://about.rdap.org/" target="_blank" rel="noopener">RDAP</a> and <a href="https://developers.google.com/speed/public-dns/docs/doh/json" target="_blank" rel="noopener">Google DNS-over-HTTPS</a>.</p>
<?php if(($section??'')===''):?><p><a href="<?=url('/'.e($domainService['slug']))?>">Open the dedicated <?=e($domainService['name'])?> page &rarr;</a></p><?php endif;?>
<noscript><p class="alert">Enable JavaScript to run domain and DNS lookups.</p></noscript>
</section>
<link rel="stylesheet" href="<?=url('/assets/css/domain-dns.css')?>"><script src="<?=url('/assets/js/domain-dns.js')?>" defer></script>
<?php endif; ?>
