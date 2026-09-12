<?php
final class ExternalRankProvider implements RankingProviderInterface {
 public function positions(array $keywords): array {
  if(rtrim((string)cfg('RANKING_ENDPOINT'),'/')==='https://api.hasdata.com/scrape/google/serp')return (new HasDataRankProvider())->positions($keywords);
  if(!cfg('RANKING_ENDPOINT')||!cfg('RANKING_API_KEY'))throw new RuntimeException('Ranking API not configured.');
  $r=SafeHttp::request(cfg('RANKING_ENDPOINT'),'POST',['Content-Type: application/json','Authorization: Bearer '.cfg('RANKING_API_KEY')],json_encode(['keywords'=>$keywords]),0);
  if($r['status']!==200)throw new RuntimeException('Ranking provider request failed.');$data=json_decode($r['body'],true,32,JSON_THROW_ON_ERROR);if(!is_array($data['rankings']??null))throw new RuntimeException('Invalid ranking provider response.');return $data['rankings'];
 }
}
