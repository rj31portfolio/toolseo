<?php
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Method not allowed.',405);
if(!DomainDns::settings()['enabled'])fail('This tool is currently disabled.',404);
check_csrf();
try{$domain=DomainDns::domain(required_input('domain',1000));}catch(InvalidArgumentException $e){fail($e->getMessage());}
$type=enum_input('type',array_merge(['RDAP'],array_keys(DomainDns::TYPES)));
rate_limit('public-domain-dns',90,60);
session_write_close();set_time_limit(60);
header('Cache-Control: no-store');
try{$result=DomainDns::lookup($domain,$type);}catch(Throwable $e){error_log('Domain DNS lookup: '.$e->getMessage());fail('The '.($type==='RDAP'?'registration':'DNS').' provider could not complete this lookup. Please try again shortly.',502);}
json_response($result,'Lookup complete');
