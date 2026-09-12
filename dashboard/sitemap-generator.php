<?php $crawlUrls=SeoFiles::crawlUrls($w); ?>
<div class="writing-layout seo-file-layout"><div class="card"><div class="writing-panel-title"><span class="service-symbol"><?=WorkspaceUI::icon('layers')?></span><div><h2>Build your XML sitemap</h2><p>List the pages you want search engines to discover.</p></div></div>
<form data-api="generate-sitemap" data-output="seo-file-output" data-reload="false">
 <input type="hidden" name="website_id" value="<?=$wid?>">
 <p class="small">Website: <strong><?=e($w['domain'])?></strong></p>
 <button type="button" class="button secondary small-button" data-load-crawl <?=!$crawlUrls?'disabled':''?>>Add crawled pages (<?=min(1000,count($crawlUrls))?>)</button>
 <textarea data-crawl-urls hidden disabled><?=e(implode("\n",array_slice($crawlUrls,0,1000)))?></textarea>
 <p class="small"><?=!$crawlUrls?'No eligible pages from a completed audit yet. Paste your URLs below or run an audit first.':'Uses same-site, HTTP 200 pages without noindex or a different canonical URL from your latest completed audit.'?><?=count($crawlUrls)>1000?' Showing the first 1,000 eligible pages.':''?></p>
 <label>Page URLs · one per line<textarea name="urls" rows="12" maxlength="500000" required placeholder="<?=e(rtrim($w['domain'],'/')."/\n".rtrim($w['domain'],'/').'/about')?>"><?=e($w['domain'])?></textarea></label>
 <p class="small">Up to 1,000 URLs per file. Duplicate URLs are removed. Use the same host and protocol as your website.</p>
 <label>Last modified date · optional<input type="date" name="lastmod" max="<?=date('Y-m-d')?>"></label><p class="small">Only set this if every listed page was actually updated on that date. Otherwise, leave it blank.</p>
 <button class="button">Generate sitemap ↗</button>
</form></div>
<?php $fileType='sitemap';require ROOT.'/dashboard/seo-file-result.php';?></div>
