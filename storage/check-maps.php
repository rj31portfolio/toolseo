<?php
require dirname(__DIR__).'/includes/bootstrap.php';
foreach(['google-maps','google/maps'] as $path){try{$r=SafeHttp::request('https://api.hasdata.com/scrape/'.$path.'/search?'.http_build_query(['q'=>'dentists in New York, NY']),'GET',['x-api-key: '.cfg('RANKING_API_KEY')],null,0,null,90);$data=json_decode($r['body'],true);echo $path.': HTTP '.$r['status'].'; keys '.implode(',',array_keys($data??[])).PHP_EOL;if($r['status']===200)echo 'Parsed '.count(BusinessLeads::parse($data)).PHP_EOL;}catch(Throwable $e){echo $e->getMessage().PHP_EOL;}}
