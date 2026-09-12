<?php $guide=WorkspaceUI::catalog()[$section]??null;if($guide):?>
<details class="tool-guide"><summary><?=WorkspaceUI::icon($guide[5])?><span>How to use <?=e(strtolower($guide[1]))?></span><span class="guide-toggle">Quick guide +</span></summary><div class="guide-grid"><div><span class="eyebrow">01 · GET STARTED</span><p><?=e($guide[3])?></p></div><div><span class="eyebrow">02 · YOUR RESULT</span><p><?=e($guide[4])?></p></div><a href="<?=url('/services?website_id='.$wid)?>">Explore all tools →</a></div></details>
<?php endif;?>
