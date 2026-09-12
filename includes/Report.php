<?php
final class Report {
 public static function create(array $w,array $u): int {
  db()->beginTransaction();
  try{
   query('SELECT id FROM users WHERE id=? FOR UPDATE',[$w['user_id']]);limit_check((int)$w['user_id'],'reports',(int)value("SELECT COUNT(*) FROM reports r JOIN websites w ON w.id=r.website_id WHERE w.user_id=? AND r.created_at>=DATE_FORMAT(NOW(),'%Y-%m-01')",[$w['user_id']]));
   $data=PerformanceReport::snapshot($w);
   query('INSERT INTO reports(website_id,user_id,title,snapshot) VALUES (?,?,?,?)',[$w['id'],$u['id'],'SEO performance report - '.date('d M Y'),json_encode($data,JSON_THROW_ON_ERROR)]);$id=(int)db()->lastInsertId();notify((int)$w['user_id'],'A new SEO performance report is ready.','/report?id='.$id.'&website_id='.$w['id']);db()->commit();return $id;
  }catch(Throwable $e){if(db()->inTransaction())db()->rollBack();throw $e;}
 }
 public static function html(array $report): string {
  $s=json_decode($report['snapshot'],true,512,JSON_THROW_ON_ERROR);
  ob_start();try{require ROOT.'/includes/performance-report.php';return ob_get_contents();}finally{ob_end_clean();}
 }
 public static function pdfDocument(array $r): Dompdf\Dompdf {
  if(!is_file(ROOT.'/vendor/autoload.php'))fail('PDF library unavailable. Run composer install on the server.',503);
  require_once ROOT.'/vendor/autoload.php';$pdf=new Dompdf\Dompdf(['isRemoteEnabled'=>false,'isPhpEnabled'=>false,'chroot'=>ROOT.'/assets']);
  $pdf->loadHtml('<html><head><meta charset="utf-8"><style>'.file_get_contents(ROOT.'/assets/css/report.css').'</style></head><body class="report-pdf">'.self::html($r).'</body></html>');$pdf->setPaper('A4');$pdf->render();
  $canvas=$pdf->getCanvas();$font=$pdf->getFontMetrics()->getFont('DejaVu Sans','normal');$canvas->page_text(42,810,'SEO performance report  |  Page {PAGE_NUM} of {PAGE_COUNT}',$font,8,[0.4,0.45,0.52]);
  return $pdf;
 }
 public static function pdf(array $r): never {
  self::pdfDocument($r)->stream('seo-performance-report-'.$r['id'].'.pdf',['Attachment'=>true]);exit;
 }
}
