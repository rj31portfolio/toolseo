<?php
final class LeadExport {
 public const COLUMNS=['business_name'=>'Business Name','category'=>'Category','city'=>'City','state'=>'State','address'=>'Address','website'=>'Website','email'=>'Public Email','phone'=>'Public Phone','source'=>'Source','score'=>'Lead Score','rating'=>'Rating','seo_score'=>'SEO Score','favorite'=>'Favorite','provenance'=>'Provenance','created_at'=>'Created'];
 public static function xlsx(array $records,string $path): void {
  if(!class_exists('ZipArchive'))fail('Excel export requires the PHP zip extension.',503);
  $zip=new ZipArchive();if($zip->open($path,ZipArchive::CREATE|ZipArchive::OVERWRITE)!==true)fail('Could not create Excel export.',500);
  $xml=fn($v)=>htmlspecialchars((string)$v,ENT_XML1|ENT_QUOTES,'UTF-8');
  $sheet='<?xml version="1.0" encoding="UTF-8"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>';
  $rowNumber=0;
  foreach([array_values(self::COLUMNS),...array_map(fn($r)=>array_map(fn($k)=>$r[$k]??'',array_keys(self::COLUMNS)),$records)] as $cells){$rowNumber++;$sheet.='<row r="'.$rowNumber.'">';foreach($cells as $col=>$v)$sheet.='<c r="'.chr(65+$col).$rowNumber.'" t="inlineStr"><is><t xml:space="preserve">'.$xml($v).'</t></is></c>';$sheet.='</row>';}
  $sheet.='</sheetData><autoFilter ref="A1:'.chr(64+count(self::COLUMNS)).$rowNumber.'"/></worksheet>';
  $files=[
   '[Content_Types].xml'=>'<?xml version="1.0"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/></Types>',
   '_rels/.rels'=>'<?xml version="1.0"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>',
   'xl/workbook.xml'=>'<?xml version="1.0"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="B2B Leads" sheetId="1" r:id="rId1"/></sheets></workbook>',
   'xl/_rels/workbook.xml.rels'=>'<?xml version="1.0"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>',
   'xl/worksheets/sheet1.xml'=>$sheet
  ];try{foreach($files as $name=>$body)if(!$zip->addFromString($name,$body))throw new RuntimeException('Excel generation failed.');}finally{$zip->close();}
 }
 public static function download(array $records,string $format): never {
  header('Cache-Control: no-store');header('X-Content-Type-Options: nosniff');
  if($format==='csv'){header('Content-Type: text/csv; charset=UTF-8');header('Content-Disposition: attachment; filename="b2b-leads.csv"');$fp=fopen('php://output','wb');fwrite($fp,"\xEF\xBB\xBF");fputcsv($fp,array_values(self::COLUMNS),',','"','');foreach($records as $r)fputcsv($fp,array_map(fn($k)=>BtoBLeads::csvCell($r[$k]??''),array_keys(self::COLUMNS)),',','"','');fclose($fp);exit;}
  $path=tempnam(sys_get_temp_dir(),'b2b-export-');if($path===false)fail('Cannot create temporary export.',500);
  try{self::xlsx($records,$path);header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');header('Content-Disposition: attachment; filename="b2b-leads.xlsx"');header('Content-Length: '.filesize($path));readfile($path);}finally{unlink($path);}exit;
 }
}
