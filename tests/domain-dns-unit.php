<?php
require __DIR__.'/unit.php';
check(DomainDns::domain(' Example.COM. ')==='example.com','Normalize domain case and trailing dot');
check(DomainDns::domain('www.example.co.uk')==='www.example.co.uk','Preserve exact subdomain');
foreach(['','localhost','127.0.0.1','https://example.com','example.com/path','example.com:443','a@b.com','-bad.com','bad-.com','a..com','foo.local',str_repeat('a',64).'.com',"a.com\nattack"] as $domain)rejects(fn()=>DomainDns::domain($domain),'Reject invalid domain '.json_encode($domain));
foreach(['admin','admin-other','login','audit','storage','seo-tools','tools','Bad-Slug','a/b','-bad','a--b'] as $slug)rejects(fn()=>DomainDns::validateSlug($slug),'Reject reserved or invalid slug '.$slug);
check(DomainDns::validateSlug('domain-ownership')==='domain-ownership','Allow custom slug');
$fixture=['objectClassName'=>'domain','ldhName'=>'EXAMPLE.COM','status'=>['active'],'events'=>[['eventAction'=>'registration','eventDate'=>'2000-01-01T00:00:00Z'],['eventAction'=>'expiration','eventDate'=>'2030-01-01T00:00:00Z']],'nameservers'=>[['ldhName'=>'ns1.example.com']],'entities'=>[['roles'=>['registrar'],'vcardArray'=>['vcard',[['fn',[],'text','Example Registrar']]]]]];
$rdap=DomainDns::lookup('example.com','RDAP',fn($url)=>['status'=>200,'body'=>json_encode($fixture)]);
check($rdap['fields']['Registrar']==='Example Registrar','Parse RDAP registrar vCard');
check($rdap['fields']['Expiry date']==='2030-01-01T00:00:00Z','Parse registration events');
check($rdap['fields']['Registrant / organization']==='Not published or redacted','Do not invent redacted ownership');
check($rdap['fields']['Nameservers']==='ns1.example.com','Parse RDAP nameservers');
check(str_contains(DomainDns::lookup('example.com','RDAP',fn()=>['status'=>404])['message'],'does not confirm availability'),'RDAP absence does not imply availability');
foreach(DomainDns::TYPES as $type=>$code){$data=DomainDns::lookup('example.com',$type,function($url)use($code){check(str_contains($url,'type='.$code),'Correct DNS query code '.$code);return ['status'=>200,'body'=>json_encode(['Status'=>0,'Answer'=>[['type'=>$code,'name'=>'example.com.','TTL'=>300,'data'=>'test']]])];});check(count($data['records'])===1,'Parse '.$type.' records');}
check(DomainDns::dns('example.com','A',['Status'=>0,'Answer'=>[['type'=>5,'data'=>'alias.example.com']]])['records']===[],'Do not mislabel CNAME answers as A records');
check(str_contains(DomainDns::dns('example.com','A',['Status'=>3])['message'],'NXDOMAIN'),'Distinguish NXDOMAIN');
rejects(fn()=>DomainDns::dns('example.com','A',['Status'=>2]),'Treat SERVFAIL as a lookup failure');
rejects(fn()=>DomainDns::dns('example.com','A',[]),'Reject malformed DNS response');
rejects(fn()=>DomainDns::lookup('example.com','RDAP',fn()=>['status'=>200,'body'=>'{}']),'Reject malformed RDAP object');
rejects(fn()=>DomainDns::lookup('example.com','A',fn()=>['status'=>200,'body'=>'invalid']),'Reject malformed JSON');
rejects(fn()=>DomainDns::lookup('example.com','A',fn()=>['status'=>429]),'Handle provider rate limiting');
echo "PASS: $total checks\n";
