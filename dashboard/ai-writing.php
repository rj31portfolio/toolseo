<div class="card stack" id="writing-tools">
 <div class="writing-panel-title"><span class="service-symbol"><?=WorkspaceUI::icon('spark')?></span><div><h2>From an idea to a finished draft.</h2><p>Choose a tool. Add your details. Make it your own.</p></div></div>
 <?php if(!cfg('AI_API_KEY')):?><div class="alert">AI is not connected yet. Your administrator can connect it in Settings.</div><?php endif;?>
 <div class="writing-options" role="group" aria-label="Choose a writing tool"><?php foreach(['titles'=>['Title ideas','edit'],'keywords'=>['Keyword ideas','search'],'blog'=>['Blog post','file'],'article'=>['Article','layers'],'humanize'=>['Humanize text','spark']] as $tool=>[$label,$icon]):?><button type="button" class="writing-option" data-writing-tool="<?=e($tool)?>" aria-pressed="false"><?=WorkspaceUI::icon($icon)?><?=e($label)?></button><?php endforeach;?></div>
 <div class="writing-layout"><div>
 <form data-api="ai-write" data-output="writing-output" data-reload="false" id="writing-form">
  <input type="hidden" name="website_id" value="<?=$wid?>">
  <div class="form-grid">
   <?php select_field('tool','Writing tool',AIWriting::tools()); ?>
   <label>Topic<input name="topic" maxlength="500" required placeholder="What would you like to write about?"></label>
   <label>Primary keyword<input name="keyword" maxlength="200"></label>
   <?php select_field('words','Blog / article target length',['500'=>'500 words','1000'=>'1,000 words','1500'=>'1,500 words','2000'=>'2,000 words'],'1000'); ?>
  </div>
  <label id="writing-source-label" hidden>Full blog or article to humanize (up to 30,000 characters)<textarea name="source" maxlength="30000" rows="14" disabled></textarea></label>
  <details class="writing-settings"><summary>Customize audience, language &amp; tone <span>Optional +</span></summary><div class="form-grid"><label>Audience<input name="audience" maxlength="300" placeholder="Who is this for?"></label><label>Language<input name="language" maxlength="60" value="English"></label><?php select_field('tone','Tone',array_combine(['Professional','Conversational','Friendly','Educational','Persuasive'],['Professional','Conversational','Friendly','Educational','Persuasive']),'Conversational'); ?></div><label>Additional instructions<textarea name="instructions" maxlength="2000" rows="3" placeholder="Key points, examples, or preferred structure"></textarea></label></details>
  <button class="button">Generate draft ↗</button><p class="small">Each successful generation uses one AI request and is saved to your history below.</p>
 </form>
 </div><div class="writing-results"><h3>Your draft</h3><p class="small">Review and refine your result before publishing.</p>
 <div class="result-placeholder" data-result-placeholder><?=WorkspaceUI::icon('file')?><strong>A little detail. A better draft.</strong><p>Fill in the form and select Generate draft. Your formatted result will appear here.</p></div>
 <pre id="writing-output" aria-live="polite" hidden></pre>
 <div class="row"><button type="button" class="button secondary" data-writing-copy>Copy result</button><button type="button" class="button secondary" data-writing-download>Download Markdown</button><button type="button" class="button secondary" data-writing-humanize>Humanize this result</button></div></div>
</div></div>
