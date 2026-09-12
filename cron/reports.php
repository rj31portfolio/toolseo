<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
if(!value("SELECT GET_LOCK('seo_report_worker',0)"))exit;
try{foreach(rows("SELECT w.* FROM websites w JOIN website_settings s ON s.website_id=w.id AND s.name='monthly_report' AND s.value='1' WHERE NOT EXISTS(SELECT 1 FROM reports r WHERE r.website_id=w.id AND r.created_at>=DATE_FORMAT(NOW(),'%Y-%m-01')) LIMIT 20") as $w){try{Report::create($w,['id'=>$w['user_id']]);}catch(HttpError $e){query("INSERT INTO system_logs(level,message) VALUES ('warning',?)",['Scheduled report: '.$e->getMessage()]);if(db()->inTransaction())db()->rollBack();}}}finally{value("SELECT RELEASE_LOCK('seo_report_worker')");}
