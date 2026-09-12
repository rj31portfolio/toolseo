<link rel="stylesheet" href="<?=url('/assets/css/no-api-tools.css')?>">
<section id="local-tools" aria-label="No-API tools">
 <div class="local-toolbar"><label>Tool<select id="local-tool"></select></label><span class="badge">Local processing</span></div>
 <div class="local-layout">
  <form id="local-form"><h2 id="local-title"></h2><div id="local-fields" class="form-grid"></div><div class="row"><button type="submit" class="button">Generate</button><button type="reset" class="button secondary">Reset</button></div></form>
  <section class="local-result" aria-label="Result"><div class="row between"><h2>Result</h2><div class="row"><button type="button" class="icon-button" id="local-copy" title="Copy result" aria-label="Copy result" disabled><?=WorkspaceUI::icon('layers')?></button><button type="button" class="icon-button" id="local-download" title="Download result" aria-label="Download result" disabled><?=WorkspaceUI::icon('file')?></button></div></div><p id="local-status" role="status" aria-live="polite"></p><div id="local-preview"></div><pre id="local-output" tabindex="0"></pre></section>
 </div>
</section>
<noscript><p class="alert">JavaScript is required for these tools.</p></noscript>
<script src="<?=url('/assets/js/qrcode.js')?>" defer></script>
<script src="<?=url('/assets/js/no-api-tools.js')?>" defer></script>
