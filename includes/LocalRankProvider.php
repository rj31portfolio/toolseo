<?php
final class LocalRankProvider implements RankingProviderInterface {
 public function positions(array $keywords): array { if(!$keywords)return []; $ids=array_column($keywords,'id');return rows('SELECT * FROM keyword_rankings WHERE keyword_id IN ('.implode(',',array_fill(0,count($ids),'?')).') ORDER BY date DESC LIMIT 500',$ids); }
}
