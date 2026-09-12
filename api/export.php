<?php
$w=website((int)($_GET['website_id']??0));$module=(string)($_GET['module']??'');if(!in_array($module,['keywords','backlinks']))fail('Invalid export module.');
header('Content-Type: text/csv; charset=utf-8');header('Content-Disposition: attachment; filename="'.$module.'.csv"');header('Cache-Control: no-store');$out=fopen('php://output','wb');
$fields=$module==='keywords'?['keyword','country','language','device','target_url','intent','tags','search_volume','difficulty','source']:['source_url','target_url','anchor','domain','domain_rating','follow','first_seen','last_seen','status','source'];fputcsv($out,$fields,',','"','');
$stmt=query('SELECT '.implode(',',$fields).' FROM '.$module.' WHERE website_id=? ORDER BY id',[$w['id']]);while($r=$stmt->fetch()){foreach($r as &$v)if(is_string($v)&&preg_match('/^[\s]*[=+@\-\t\r]/u',$v))$v="'".$v;unset($v);fputcsv($out,array_values($r),',','"','');}fclose($out);exit;
