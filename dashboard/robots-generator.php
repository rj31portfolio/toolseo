<div class="writing-layout seo-file-layout"><div class="card"><div class="writing-panel-title"><span class="service-symbol"><?=WorkspaceUI::icon('code')?></span><div><h2>Create your robots.txt</h2><p>Choose which paths crawlers may access.</p></div></div>
<form data-api="generate-robots" data-output="seo-file-output" data-reload="false">
 <input type="hidden" name="website_id" value="<?=$wid?>">
 <label>Crawlers · one user-agent per line<textarea name="agents" maxlength="2000" rows="2" required>*</textarea></label><p class="small">Use * for all crawlers, or names such as Googlebot. All listed crawlers share the rules below.</p>
 <label>Disallowed paths · optional<textarea name="disallow" maxlength="30000" rows="5" placeholder="/admin/&#10;/private/"></textarea></label>
 <div class="alert" data-block-all hidden>Disallow: / blocks crawling across the whole site for these crawlers, except paths matched by applicable Allow rules.</div>
 <label>Allowed exceptions · optional<textarea name="allow" maxlength="30000" rows="3" placeholder="/private/public-page/"></textarea></label><p class="small">One path per line, starting with /. You can use * wildcards and $ to match the end of a URL. Empty rules allow crawling.</p>
 <label>Sitemap URLs · optional, one per line<textarea name="sitemaps" maxlength="30000" rows="3"><?=e(rtrim($w['domain'],'/').'/sitemap.xml')?></textarea></label>
 <button class="button">Generate robots.txt ↗</button>
</form></div>
<?php $fileType='robots';require ROOT.'/dashboard/seo-file-result.php';?></div>
