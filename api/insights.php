<?php
if($action==='research'){
 $seed=required_input('seed',190);session_write_close();set_time_limit(120);
 try{$result=KeywordAnalysis::research($w,$seed);}catch(RuntimeException $e){fail($e->getMessage(),503);}
 json_response(['redirect'=>url('/research?website_id='.$w['id'])],'Keyword research saved');
}
if($action==='research-add'){
 $research=Serp::saved((int)$w['id'],'keyword_research');$index=(int)input('index',5,'-1');$idea=$research['ideas'][$index]??null;
 if(!$idea)fail('Run keyword research and select a saved suggestion.');
 $_POST=['keyword'=>$idea['keyword'],'country'=>$research['country'],'language'=>$research['language'],'device'=>'desktop','search_engine'=>'google'];
 if(value("SELECT id FROM keywords WHERE website_id=? AND keyword=? AND country=? AND device='desktop'",[$w['id'],$idea['keyword'],$research['country']]))json_response([],'Keyword is already tracked');
 $id=Modules::save('keywords',$w);
 query('UPDATE keywords SET search_volume=?,difficulty=?,cpc=?,source=? WHERE id=? AND website_id=?',[$idea['search_volume']??null,$idea['difficulty']??null,$idea['cpc']??null,'research',$id,$w['id']]);
 json_response([],'Keyword added to tracking');
}
if($action==='backlink-check'){
 $link=row('SELECT * FROM backlinks WHERE id=? AND website_id=?',[(int)input('id',12),$w['id']]);if(!$link)fail('Backlink not found in this project.',404);
 session_write_close();set_time_limit(240);$result=Backlink::check($link);json_response($result,$result['message']);
}
if($action==='backlink-discover'){
 session_write_close();set_time_limit(120);try{$result=Backlink::discover($w);}catch(RuntimeException $e){fail($e->getMessage(),503);}
 json_response([],'Search candidates saved. Verify a source page before treating it as a backlink.');
}
if($action==='backlink-add-candidate'){
 $discovery=Serp::saved((int)$w['id'],'backlink_discovery');$candidate=$discovery['candidates'][(int)input('index',5,'-1')]??null;
 if(!$candidate)fail('Search for referring pages first.');
 $existing=row('SELECT * FROM backlinks WHERE website_id=? AND source_url=? AND target_url=?',[$w['id'],$candidate['url'],$w['domain']]);
 if($existing)json_response([],'This source is already in your backlink inventory');
 // Verify before adding so a search mention never becomes an invented backlink.
 session_write_close();set_time_limit(240);
 $probe=['id'=>0,'website_id'=>$w['id'],'source_url'=>$candidate['url'],'target_url'=>$w['domain']];
 $result=Backlink::check($probe);
 if($result['state']!=='verified')fail($result['message']);
 $match=$result['matches'][0];query("INSERT INTO backlinks(website_id,source_url,target_url,anchor,domain,follow,first_seen,last_seen,status,source) VALUES (?,?,?,?,?,?,CURDATE(),CURDATE(),'active','verified')",[$w['id'],$candidate['url'],$w['domain'],$match['anchor'],parse_url($candidate['url'],PHP_URL_HOST),$match['follow']]);$id=(int)db()->lastInsertId();
 Serp::save((int)$w['id'],'backlink_check_'.$id,$result);json_response([],'Verified backlink added');
}
