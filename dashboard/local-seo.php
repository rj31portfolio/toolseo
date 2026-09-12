<?php
$localSeoRoute=$localSeoRoute??'/local-seo';
if(!LocalSeoAudit::ready()){echo '<div class="alert">Local SEO storage is not installed. Ask your administrator to run <code>php cron/migrate-local-seo.php</code>.</div>';return;}
$selected=(int)($_GET['audit_id']??0);$audit=$selected?LocalSeoAudit::get($wid,$selected):null;
$latest=$audit?null:row('SELECT id FROM local_seo_audits WHERE website_id=? ORDER BY id DESC LIMIT 1',[$wid]);
$prefill=$audit??($latest?LocalSeoAudit::get($wid,(int)$latest['id']):null);$p=$prefill['data']['profile']??[];
$page=max(1,(int)($_GET['history_page']??1));$count=(int)value('SELECT COUNT(*) FROM local_seo_audits WHERE website_id=?',[$wid]);$page=min($page,max(1,(int)ceil($count/10)));
$history=rows('SELECT id,business_name,score,scoring_version,created_at FROM local_seo_audits WHERE website_id=? ORDER BY id DESC LIMIT 10 OFFSET '.(($page-1)*10),[$wid]);
?>
<div class="card"><div class="card-header"><div><h2>Google Business Profile / Local SEO Analyzer</h2><p class="small">A manual readiness audit for your business profile and local landing page.</p></div><span class="badge">No API · No live requests</span></div><p class="small">Enter what you know. Compare the profile with website and directory details, review the score breakdown, and download a saved report. This is an internal checklist, not a Google score or ranking prediction.</p><div class="row local-seo-actions"><a class="button" href="#local-seo-form">New audit</a><a class="button secondary" href="#local-seo-history">Audit history (<?=$count?>)</a><?php if($audit):?><a class="button secondary" href="<?=url('/api/v1/local-seo-pdf?website_id='.$wid.'&audit_id='.$audit['id'])?>">Download PDF</a><?php endif;?></div></div>
<?php if($audit){$data=$audit['data'];require ROOT.'/dashboard/local-seo-results.php';} ?>
<details class="card stack local-seo-form-section" id="local-seo-form" <?=$audit?'':'open'?>><summary><strong><?=$prefill?'Run a new audit using these details':'Enter your business details'?></strong><span class="small">Every audit saves a separate snapshot. Previous audits remain unchanged.</span></summary>
<?php require ROOT.'/dashboard/local-seo-form.php';?>
</details>
<section class="card stack" id="local-seo-history"><h2>Local SEO audit history</h2><p class="small">Saved inputs, scoring version, recommendations and schema are retained with each audit. Scores from different businesses or versions should not be compared directly.</p>
<?php if(!$history):empty_state('No local audits yet','Enter your business details and run your first local SEO audit.');else:?>
<div class="table-wrap"><table><thead><tr><th>Business</th><th>Score</th><th>Saved (UTC)</th><th>Version</th><th>Results</th></tr></thead><tbody><?php foreach($history as $entry):?><tr><td><?=e($entry['business_name'])?></td><td><strong><?=$entry['score']?> / 100</strong></td><td><?=e($entry['created_at'])?></td><td><?=$entry['scoring_version']?></td><td><a class="button secondary small-button" href="<?=url($localSeoRoute.'?website_id='.$wid.'&audit_id='.$entry['id'].'#local-seo-results')?>">View audit</a> <a class="button secondary small-button" href="<?=url('/api/v1/local-seo-pdf?website_id='.$wid.'&audit_id='.$entry['id'])?>">PDF</a></td></tr><?php endforeach;?></tbody></table></div>
<nav class="pagination" aria-label="Local SEO audit history"><?php if($page>1):?><a href="<?=url($localSeoRoute.'?website_id='.$wid.'&history_page='.($page-1).'#local-seo-history')?>">Previous</a><?php endif;?><span>Page <?=$page?> of <?=max(1,(int)ceil($count/10))?></span><?php if($page*10<$count):?><a href="<?=url($localSeoRoute.'?website_id='.$wid.'&history_page='.($page+1).'#local-seo-history')?>">Next</a><?php endif;?></nav>
<?php endif;?></section>
<script src="<?=url('/assets/js/local-seo.js?v='.filemtime(ROOT.'/assets/js/local-seo.js'))?>" defer></script>
