<?php
require dirname(__DIR__).'/includes/bootstrap.php';
foreach(array_keys(BusinessLeads::SOURCES) as $source){try{$results=BusinessLeads::search($source,'dentists','New York, NY',1);echo $source.': '.count($results)." valid results (not saved)\n";}catch(Throwable $e){echo $source.': '.$e->getMessage()."\n";}}
