<?php
$admin=require_admin();check_csrf();
if(!Launch::ready())fail('Run cron/migrate-launch.php to install blog and lead storage.',503);
if($op==='blog-save'){
 $id=(int)input('id',12,'0');$existing=$id?row('SELECT * FROM zentro_posts WHERE id=?',[$id]):null;if($id&&!$existing)fail('Article not found.',404);
 $slug=required_input('slug',160);if(!preg_match('/^[a-z0-9]+(?:-[a-z0-9]+)*$/D',$slug))fail('Use lowercase words separated by hyphens for the URL.');
 if(value('SELECT id FROM zentro_posts WHERE slug=? AND id<>?',[$slug,$id]))fail('This article URL is already in use.');
 $title=required_input('title',180);$description=required_input('description',320);$content=required_input('content',60000);$status=enum_input('status',['draft','published']);$alt=input('image_alt',200);$image=Launch::upload()?:($existing['image']??'');if($image&&$alt==='')fail('Describe the cover image for accessibility.');
 $published=$existing['published_at']??($status==='published'?date('Y-m-d H:i:s'):null);
 $args=[$slug,$title,$description,$content,$image,$alt,$status,$published];
 if($id)query('UPDATE zentro_posts SET slug=?,title=?,description=?,content=?,image=?,image_alt=?,status=?,published_at=? WHERE id=?',[...$args,$id]);else{query('INSERT INTO zentro_posts(slug,title,description,content,image,image_alt,status,published_at) VALUES (?,?,?,?,?,?,?,?)',$args);$id=(int)db()->lastInsertId();}
 audit_log('blog.saved',['id'=>$id,'status'=>$status]);json_response(['redirect'=>url('/admin/blog?edit='.$id)],'Article saved.');
}
if($op==='social-save'){
 require_admin(true);foreach(['instagram','facebook','youtube','pinterest'] as $network){$v=input($network,500);if($v!==''&&Launch::safeUrl($v)==='')fail('Enter a full https:// social profile URL.');query('INSERT INTO settings(name,value) VALUES (?,?) ON DUPLICATE KEY UPDATE value=VALUES(value)',['social_'.$network,json_encode($v)]);}json_response([],'Social profiles saved.');
}
$source=enum_input('source',array_keys(BusinessLeads::SOURCES));
if($op==='lead-export'){
 header('Content-Type: text/csv; charset=utf-8');header('Content-Disposition: attachment; filename="'.$source.'-leads.csv"');header('Cache-Control: no-store');$out=fopen('php://output','w');fputcsv($out,['Business','Phone','Website','Address','Listing']);
 foreach(rows('SELECT business_name,phone,website,address,listing_url FROM zentro_leads WHERE source=? ORDER BY id DESC LIMIT 10000',[$source]) as $r)fputcsv($out,array_map(static fn($v)=>preg_match('/^[\s]*[=+@-]/u',$v)?"'".$v:$v,array_values($r)));fclose($out);exit;
}
if($op==='lead-search'){
 rate_limit('business-search:'.$admin['id'],10,300);$keyword=required_input('keyword',150);$location=required_input('location',150);$page=filter_var(input('page',3,'1'),FILTER_VALIDATE_INT,['options'=>['min_range'=>1,'max_range'=>50]]);if(!$page)fail('Choose page 1 to 50.');session_write_close();set_time_limit(120);
 $results=BusinessLeads::search($source,$keyword,$location,$page);$added=0;
 foreach($results as $hash=>$r)$added+=query('INSERT IGNORE INTO zentro_leads(source,fingerprint,business_name,phone,website,address,listing_url,created_by) VALUES (?,?,?,?,?,?,?,?)',[$source,$hash,...array_values($r),$admin['id']])->rowCount();
 audit_log('business_leads.searched',['source'=>$source,'count'=>count($results)]);json_response(['redirect'=>url('/admin/'.$source.'-leads')],count($results).' results; '.$added.' new leads saved.');
}
fail('Unknown action.',404);
