<?php
final class GatewayProvider implements KeywordProviderInterface,BacklinkProviderInterface {
 public function research(string $seed,string $country,string $language): array {return $this->request('KEYWORD',['seed'=>$seed,'country'=>$country,'language'=>$language],'keywords');}
 public function backlinks(string $domain): array {return $this->request('BACKLINK',['domain'=>$domain],'backlinks');}
 private function request(string $prefix,array $payload,string $key): array {
  if(!cfg($prefix.'_ENDPOINT')||!cfg($prefix.'_API_KEY'))fail(ucfirst(strtolower($prefix)).' data source unavailable. Configure a provider gateway.',503);
  $r=SafeHttp::request(cfg($prefix.'_ENDPOINT'),'POST',['Content-Type: application/json','Authorization: Bearer '.cfg($prefix.'_API_KEY')],json_encode($payload),0);if($r['status']!==200)fail('The data provider request failed.',503);try{$d=json_decode($r['body'],true,32,JSON_THROW_ON_ERROR);}catch(Throwable){fail('Invalid provider response.',503);}if(!is_array($d[$key]??null))fail('Invalid provider response.',503);return array_slice($d[$key],0,100);
 }
}
