<?php
$catalog=WorkspaceUI::directory();
$groups=['Workspace'=>['dashboard'=>['Overview','grid'],'services'=>['All tools & services','layers'],'websites'=>['My websites','globe']]];
foreach($catalog as $key=>[$group,$name,$description,$steps,$result,$icon])$groups[$group][$key]=[$name,$icon];
$groups['Account']=['billing'=>['Plan & billing','file'],'profile'=>['My profile','settings']];
?>
<aside class="sidebar" id="sidebar">
 <a class="logo" href="<?=url('/dashboard')?>"><span class="logo-symbol">↗</span><span>SEO<strong>AutoPilot</strong><small>YOUR GROWTH WORKSPACE</small></span></a>
 <label class="nav-search"><?=WorkspaceUI::icon('search')?><input type="search" data-nav-search placeholder="Find a tool…" aria-label="Find a navigation item"></label>
 <nav aria-label="Workspace">
 <?php foreach($groups as $heading=>$items):?><div class="nav-group"><h2 class="nav-group-title"><?=e($heading)?></h2><?php foreach($items as $key=>[$label,$icon]):?><a class="nav-item <?=$section===$key?'active':''?>" <?=$section===$key?'aria-current="page"':''?> href="<?=url('/'.$key).($wid?'?website_id='.$wid:'')?>"><?=WorkspaceUI::icon($icon)?><span><?=e($label)?></span><?php if($key==='ai-assistant'):?><small>AI</small><?php endif;?></a><?php endforeach;?></div><?php endforeach;?>
 <?php if(is_admin()):?><div class="nav-group"><h2 class="nav-group-title">Administration</h2><a class="nav-item" href="<?=url('/admin')?>"><?=WorkspaceUI::icon('settings')?><span>Administration</span></a></div><?php endif;?>
 <p class="nav-empty" data-nav-empty hidden>No matching tools.</p>
 </nav>
 <div class="sidebar-bottom"><a class="user-pill" href="<?=url('/profile')?>"><span class="avatar"><?=e(mb_substr($user['name'],0,1))?></span><span><?=e($user['name'])?><small><?=e(ucwords(str_replace('_',' ',$user['role'])))?></small></span></a><form method="post" action="<?=url('/logout')?>"><?php csrf_field();?><button class="text-button">Sign out</button></form></div>
</aside>
<button type="button" class="sidebar-scrim" data-close-sidebar aria-label="Close navigation" hidden></button>
