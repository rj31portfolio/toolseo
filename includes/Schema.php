<?php
final class Schema {
 public static function types(): array {return ['Organization','LocalBusiness','Product','Article','BlogPosting','FAQPage','BreadcrumbList','WebSite','WebPage','Service','Person','Event'];}
 public static function generate(string $type,string $json): string {
  if(!in_array($type,self::types(),true))fail('Unsupported schema type.');try{$d=json_decode($json,true,32,JSON_THROW_ON_ERROR);}catch(Throwable){fail('Enter valid JSON properties.');}if(!is_array($d)||array_is_list($d))fail('Properties must be a JSON object.');unset($d['@context'],$d['@type']);
  if($type==='FAQPage' && !is_array($d['mainEntity']??null))fail('FAQPage requires a mainEntity array of Question objects.');
  if($type==='BreadcrumbList' && !is_array($d['itemListElement']??null))fail('BreadcrumbList requires itemListElement entries.');
  if(!in_array($type,['FAQPage','BreadcrumbList']) && empty($d['name']) && empty($d['headline']))fail('Provide a name or headline.');
  return json_encode(['@context'=>'https://schema.org','@type'=>$type]+$d,JSON_PRETTY_PRINT|JSON_UNESCAPED_UNICODE|JSON_UNESCAPED_SLASHES|JSON_HEX_TAG|JSON_THROW_ON_ERROR);
 }
}
