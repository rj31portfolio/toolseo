<?php
final class InternalLinks {
 public static function generate(array $w): void {
  $job=value("SELECT id FROM crawl_jobs WHERE website_id=? AND status='completed' ORDER BY id DESC LIMIT 1",[$w['id']]);if(!$job)fail('Complete a crawl first.');$pages=rows('SELECT url,title,h1,details,internal_links FROM pages WHERE job_id=? LIMIT 300',[$job]);$added=0;
  foreach($pages as $source){$text=mb_strtolower(json_decode($source['details'],true)['text']??'');$links=json_decode($source['internal_links'],true);foreach($pages as $target){if($source['url']===$target['url']||in_array($target['url'],$links??[],true))continue;$anchor=trim($target['h1']?:$target['title']);if(mb_strlen($anchor)<5||mb_strlen($anchor)>90||!str_contains($text,mb_strtolower($anchor)))continue;if(value('SELECT id FROM internal_link_suggestions WHERE website_id=? AND source_url=? AND target_url=?',[$w['id'],$source['url'],$target['url']]))continue;query('INSERT INTO internal_link_suggestions(website_id,source_url,target_url,anchor) VALUES (?,?,?,?)',[$w['id'],$source['url'],$target['url'],$anchor]);if(++$added>=100)return;}}
 }
}
