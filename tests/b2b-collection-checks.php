<?php
// Included by the isolated B2B runner.
$listing='https://www.indiamart.com/fixture/';
$fixture='<html><script type="application/ld+json">'.json_encode(['@graph'=>[
 ['@type'=>'Organization','name'=>'IndiaMART','telephone'=>'+91 9999999999'],
 ['@type'=>'LocalBusiness','name'=>'Collected Packaging','category'=>'Packaging','url'=>'https://example.com/','address'=>['@id'=>'#address'],'contactPoint'=>['@id'=>'#contact']],
 ['@id'=>'#address','@type'=>'PostalAddress','streetAddress'=>'10 Market Road','addressLocality'=>'Mumbai','addressRegion'=>'Maharashtra','postalCode'=>'400001'],
 ['@id'=>'#contact','@type'=>'ContactPoint','email'=>'sales@example.com','telephone'=>'+91 2222222222'],
 ['@type'=>'Organization','name'=>'Other Supplier','address'=>['addressLocality'=>'Delhi'],'telephone'=>'masked XXXX'],
 ['@type'=>'Product','name'=>'Box','telephone'=>'+91 8888888888']
]]).'</script></html>';
$collected=LeadCollector::parse($fixture,$listing,'1');
verifyLead(count($collected)===2,'Collector excludes marketplace and product entities');
verifyLead($collected[0]['business_name']==='Collected Packaging'&&$collected[0]['email']==='sales@example.com'&&$collected[0]['phone']==='+91 2222222222','Collector resolves referenced business contacts');
verifyLead($collected[0]['address']==='10 Market Road, Mumbai, Maharashtra, 400001'&&$collected[0]['city']==='Mumbai'&&$collected[0]['website']==='https://example.com/','Collector extracts address and business website');
verifyLead($collected[1]['email']===''&&$collected[1]['phone']===''&&$collected[1]['city']==='Delhi','Collector never mixes contacts or invents masked numbers');
$micro='<div itemscope itemtype="https://schema.org/LocalBusiness"><h2 itemprop="name">Micro Supplier</h2><a itemprop="email" href="mailto:micro@example.com">Email</a><div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress"><span itemprop="addressLocality">Pune</span></div></div>';
$microLead=LeadCollector::parse($micro,$listing,'1');
verifyLead(count($microLead)===1&&$microLead[0]['city']==='Pune'&&$microLead[0]['email']==='micro@example.com','Collector reads scoped microdata');
verifyLead(LeadCollector::parse('<html><h1>Suppliers</h1><a href="tel:9999999999">Support</a></html>',$listing,'1')===[],'Unscoped page support numbers are not lead contacts');
$card='<article class="template7-product-card"><a class="template7-seller-name" href="https://example.com/">Visible Supplier</a><a class="template7-product-name">Packaging boxes</a><span itemProp="addressLocality">Mumbai</span><a href="tel:+912222222222">Call</a></article>';
$cardLead=LeadCollector::parse($card,$listing,'1');
verifyLead(count($cardLead)===1&&$cardLead[0]['business_name']==='Visible Supplier'&&$cardLead[0]['phone']==='+912222222222'&&$cardLead[0]['city']==='Mumbai','Collector extracts visible IndiaMART seller cards');
verifyLead(LeadCollector::parse(str_replace('>Mumbai<','>Deals in Mumbai<',$card),$listing,'1')[0]['city']==='','Service areas are not assigned as business addresses');
$fetch=static function($url,$method,$headers,$body,$redirects,$guard)use($fixture){
 verifyLead($guard($url)&&!$guard('https://example.org/'),'Collector restricts redirect scope');
 return ['url'=>$url,'status'=>200,'headers'=>['content-type'=>'text/html'],'body'=>str_ends_with($url,'robots.txt')?'User-agent: *':$fixture];
};
verifyLead(count(LeadCollector::collect(['source_id'=>'1','url'=>$listing],$fetch))===2,'Collector fetches and parses public listing');
rejectLead(fn()=>LeadCollector::collect(['source_id'=>'1','url'=>'https://indiamart.com.example.org/'],$fetch),'Collector rejects spoofed marketplace host');
rejectLead(fn()=>LeadCollector::collect(['source_id'=>'1','url'=>$listing],static fn()=>['status'=>200,'body'=>"User-agent: *\nDisallow: /"]),'Collector respects disallowed pages');
$savedCollected=BtoBLeads::save($collected[0],1);
verifyLead(BtoBLeads::get($savedCollected)['address']===$collected[0]['address'],'Collected full address survives save and reload');
query('DELETE FROM leads WHERE id=?',[$savedCollected]);
// Restore sequence because existing demo fixtures intentionally use IDs 1 through 5.
query('ALTER TABLE leads AUTO_INCREMENT=1');
