<?php
final class PerformanceReport {
 public static function snapshot(array $w): array {
  $wid=(int)$w['id'];$audit=row('SELECT * FROM seo_audits WHERE website_id=? ORDER BY id DESC LIMIT 1',[$wid]);
  $keywords=KeywordAnalysis::keywords($wid);$backlinks=rows('SELECT * FROM backlinks WHERE website_id=? ORDER BY id',[$wid]);
  $checks=[];foreach(rows("SELECT name,value FROM website_settings WHERE website_id=? AND name LIKE 'backlink_check_%'",[$wid]) as $r)$checks[(int)substr($r['name'],15)]=json_decode($r['value'],true)?:[];
  $verified=0;foreach($backlinks as &$b){$b['verification']=$checks[$b['id']]??[];if(($b['verification']['state']??'')==='verified')$verified++;}unset($b);
  $issueSummary=$audit?rows('SELECT severity,status,COUNT(*) AS total FROM seo_issues WHERE audit_id=? GROUP BY severity,status',[$audit['id']]):[];
  $issues=$audit?rows("SELECT title,severity,category,url,recommendation,explanation,status FROM seo_issues WHERE audit_id=? ORDER BY status='open' DESC,FIELD(severity,'critical','high','medium','low','opportunity'),id LIMIT 500",[$audit['id']]):[];
  $crawl=$audit?row('SELECT * FROM crawl_jobs WHERE id=?',[$audit['job_id']]):null;
  $pages=$audit?rows('SELECT url,title,http_status,score,load_ms,word_count,noindex,missing_alt FROM pages WHERE job_id=? ORDER BY score,url LIMIT 50',[$audit['job_id']]):[];
  $pageSummary=$audit?row('SELECT COUNT(*) AS total,SUM(http_status>=400) AS errors,SUM(noindex=1) AS noindex,SUM(title IS NULL OR title="") AS missing_titles,SUM(description IS NULL OR description="") AS missing_descriptions,SUM(missing_alt) AS missing_alt,ROUND(AVG(load_ms)) AS average_response_ms FROM pages WHERE job_id=?',[$audit['job_id']]):null;
  $trend=array_reverse(rows('SELECT score,created_at FROM seo_audits WHERE website_id=? ORDER BY id DESC LIMIT 12',[$wid]));
  $rankTrend=rows('SELECT r.date AS label,ROUND(AVG(r.position),1) AS value,COUNT(r.position) AS ranked FROM keyword_rankings r JOIN keywords k ON k.id=r.keyword_id WHERE k.website_id=? AND r.date>=DATE_SUB(CURDATE(),INTERVAL 90 DAY) GROUP BY r.date ORDER BY r.date',[$wid]);
  $tasks=rows('SELECT title,status,priority,due_date,url FROM seo_tasks WHERE website_id=? ORDER BY status="completed",id DESC',[$wid]);
  $brand=[];if(plan((int)$w['user_id'])['white_label'])foreach(rows("SELECT name,value FROM website_settings WHERE website_id=? AND name IN ('agency_name','agency_website','agency_contact','report_footer','brand_color','logo_data','client_name','client_email')",[$wid]) as $r)$brand[$r['name']]=$r['value'];
  return ['version'=>2,'website'=>$w,'audit'=>$audit,'crawl'=>$crawl,'issues'=>$issues,'issue_summary'=>$issueSummary,'keywords'=>$keywords,'keyword_summary'=>KeywordAnalysis::summarize($keywords),'backlinks'=>$backlinks,'verified_backlinks'=>$verified,'competitors'=>rows('SELECT domain,notes FROM competitors WHERE website_id=? ORDER BY id',[$wid]),'tasks'=>$tasks,'branding'=>$brand,'pages'=>$pages,'page_summary'=>$pageSummary,'audit_trend'=>$trend,'rank_trend'=>$rankTrend,'research'=>Serp::saved($wid,'keyword_research'),'coverage'=>['issue_details_limit'=>500,'page_details_limit'=>50],'captured_at'=>date('Y-m-d H:i:s')];
 }
 public static function rankLabel(array $k): string {
  if(($k['position']??null)!==null)return '#'.$k['position'];
  if(($k['ranking_source']??'')==='hasdata_top100')return 'Not found (up to 100)';
  if(!empty($k['ranking_date']))return 'Not found in checked results';
  return array_key_exists('ranking_date',$k)?'Not checked':'Not recorded';
 }
 public static function table(array $columns,array $records,string $empty='No recorded data available.'): void {
  if(!$records){echo '<p class="report-empty">'.e($empty).'</p>';return;}
  echo '<div class="table-wrap"><table class="performance-table"><thead><tr>';foreach($columns as $label)echo '<th>'.e($label).'</th>';echo '</tr></thead><tbody>';
  foreach($records as $record){echo '<tr>';foreach($columns as $key=>$label)echo '<td>'.e($record[$key]??'Not recorded').'</td>';echo '</tr>';}echo '</tbody></table></div>';
 }
}
