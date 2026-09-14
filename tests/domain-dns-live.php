<?php
require dirname(__DIR__).'/includes/bootstrap.php';
foreach(array_merge(['RDAP'],array_keys(DomainDns::TYPES)) as $type){
 try{$result=DomainDns::lookup('example.com',$type);echo $type.': '.(isset($result['fields'])?'registration returned':count($result['records']??[]).' records')."\n";}
 catch(Throwable $e){fwrite(STDERR,$type.': '.$e->getMessage()."\n");exit(1);}
}
