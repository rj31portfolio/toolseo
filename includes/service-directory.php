<?php
$directoryItems=$directoryItems??WorkspaceUI::directory();$directoryGroups=[];
foreach($directoryItems as $key=>$item)$directoryGroups[$item[0]][$key]=$item;
?>
<link rel="stylesheet" href="<?=url('/assets/css/service-directory.css')?>">
<div class="service-toolbar"><div class="service-filters" role="group" aria-label="Filter tools">
<?php foreach(array_merge(['All tools'],array_keys($directoryGroups)) as $group):?><button type="button" class="filter-chip <?=$group==='All tools'?'selected':''?>" data-service-filter="<?=e($group)?>" aria-pressed="<?=$group==='All tools'?'true':'false'?>"><?=e($group)?></button><?php endforeach;?>
</div><label class="service-search">Find a tool<input type="search" data-service-search placeholder="Search by service name"></label></div>
<?php foreach($directoryGroups as $group=>$items):?>
<section class="service-category-section" data-service-section><h2><?=e($group)?></h2><div class="service-grid">
<?php foreach($items as $key=>[$category,$name,$description,$steps,$result,$icon]):
 $target=($directoryAdmin??false)?'/admin/tools?tool='.substr($key,6):'/'.$key;
?><a class="service-card" data-service-group="<?=e($category)?>" href="<?=url($target)?>"><div class="service-card-top"><span class="service-symbol"><?=WorkspaceUI::icon($icon)?></span><span class="service-category"><?=e($category)?></span></div><h3><?=e($name)?></h3><?php if($description):?><p><?=e($description)?></p><?php endif;?><span class="service-open">Open tool <span aria-hidden="true">&rarr;</span></span></a><?php endforeach;?></div></section>
<?php endforeach;?>
<p class="empty" data-service-empty hidden>No tools match your search.</p>
