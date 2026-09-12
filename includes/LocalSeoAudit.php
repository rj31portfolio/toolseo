<?php
final class LocalSeoAudit {
 public static function ready(): bool {return (bool)value("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='local_seo_audits'");}
 public static function save(array $w,array $profile): int {
  if(!self::ready())fail('Local SEO storage is not installed. Ask your administrator to run the Local SEO migration.',503);
  $snapshot=LocalSeo::analyze($profile);$u=require_user();
  db()->beginTransaction();try{
   query('INSERT INTO local_seo_audits(website_id,created_by,business_name,score,scoring_version,snapshot) VALUES (?,?,?,?,?,?)',[$w['id'],$u['id'],$profile['business_name'],$snapshot['score'],LocalSeo::VERSION,json_encode($snapshot,JSON_UNESCAPED_UNICODE|JSON_THROW_ON_ERROR)]);
   $id=(int)db()->lastInsertId();audit_log('local-seo.audit.created',['id'=>$id,'website_id'=>$w['id']]);db()->commit();return $id;
  }catch(Throwable $e){if(db()->inTransaction())db()->rollBack();throw $e;}
 }
 public static function get(int $wid,int $id): array {
  $r=row('SELECT * FROM local_seo_audits WHERE website_id=? AND id=?',[$wid,$id]);if(!$r)fail('Local SEO audit not found in this project.',404);$r['data']=json_decode($r['snapshot'],true,64,JSON_THROW_ON_ERROR);return $r;
 }
 public static function pdf(array $audit): never {
  if(!is_file(ROOT.'/vendor/autoload.php'))fail('PDF library unavailable. Ask your administrator to run composer install.',503);
  require_once ROOT.'/vendor/autoload.php';$data=$audit['data'];ob_start();try{require ROOT.'/includes/local-seo-pdf.php';$html=ob_get_contents();}finally{ob_end_clean();}
  $pdf=new Dompdf\Dompdf(['isRemoteEnabled'=>false,'isPhpEnabled'=>false,'chroot'=>ROOT.'/assets']);$pdf->loadHtml($html,'UTF-8');$pdf->setPaper('A4');$pdf->render();$canvas=$pdf->getCanvas();$font=$pdf->getFontMetrics()->getFont('DejaVu Sans','normal');$canvas->page_text(36,815,'Local SEO audit '.$audit['id'].' | Page {PAGE_NUM} of {PAGE_COUNT}',$font,8,[.35,.4,.35]);$pdf->stream('local-seo-audit-'.$audit['id'].'.pdf',['Attachment'=>true]);exit;
 }
}
