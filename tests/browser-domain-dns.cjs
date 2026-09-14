const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const assert=require('assert/strict'),fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const base=process.env.TEST_BASE||'http://127.0.0.1:8086';
 try{
  const guest=await browser.newContext({viewport:{width:390,height:844}}),page=await guest.newPage(),errors=[];
  page.on('pageerror',e=>errors.push(e.message));await page.goto(base+'/');assert.ok(await page.locator('#domain-dns-form').isVisible());
  await page.goto(base+'/domain-dns-checker');assert.ok(!page.url().includes('login'));assert.ok(await page.locator('#domain-dns-form').isVisible());
  const token=await page.locator('meta[name=csrf-token]').getAttribute('content');
  assert.equal((await guest.request.post(base+'/api/v1/domain-dns',{form:{domain:'example.com',type:'A'}})).status(),419);
  assert.equal((await guest.request.post(base+'/api/v1/domain-dns',{form:{csrf:token,domain:'127.0.0.1',type:'A'}})).status(),422);
  assert.equal((await guest.request.get(base+'/api/v1/domain-dns')).status(),405);
  for(const type of ['A','RDAP']){const response=await guest.request.post(base+'/api/v1/domain-dns',{form:{csrf:token,domain:'example.com',type}});assert.equal(response.status(),200);const payload=await response.json();assert.ok(payload.success);assert.ok(type==='A'?payload.data.records.length>0:payload.data.fields.Registrar);}
  await page.route('**/api/v1/domain-dns',async route=>{
   const raw=route.request().postData(),type=raw.match(/name="type"\r\n\r\n([^\r]+)/)[1];
   await new Promise(resolve=>setTimeout(resolve,200));
   if(type==='AAAA')return route.fulfill({status:502,json:{success:false,message:'DNS provider unavailable. Retry shortly.'}});
   return route.fulfill({json:{success:true,data:type==='RDAP'?{fields:{Registrar:'Example Registrar','Registrant / organization':'Not published or redacted'}}:{records:[{name:'example.com.',ttl:300,data:type==='TXT'?'<img src=x onerror=alert(1)> '+'long'.repeat(100):'Test record'}]}}});
  });
  await page.locator('#domain-dns-input').fill('example.com');await page.locator('#domain-dns-form button').click();assert.equal(await page.locator('#domain-dns-form button').isDisabled(),true);
  await page.waitForFunction(()=>!document.querySelector('#domain-dns-form button').disabled);
  assert.equal(await page.locator('#domain-dns-results .card').count(),9);assert.equal(await page.locator('#domain-dns-results img').count(),0);
  assert.ok((await page.locator('#domain-dns-status').textContent()).includes('1 lookup(s) failed'));
  for(const width of [390,1440]){await page.setViewportSize({width,height:1000});assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),'No page overflow at '+width);await page.screenshot({path:`storage/domain-dns-${width}.png`,fullPage:true});}
  await page.unroute('**/api/v1/domain-dns');
  const admin=await browser.newContext(),adminPage=await admin.newPage();await adminPage.goto(base+'/admin/tools');
  const credentials=JSON.parse(fs.readFileSync(process.env.TEST_CREDENTIALS||'storage/test-credentials.json','utf8'));await adminPage.locator('[name=email]').fill(credentials.email);await adminPage.locator('[name=password]').fill(credentials.password);await Promise.all([adminPage.waitForURL('**/dashboard'),adminPage.locator('form button').click()]);await adminPage.goto(base+'/admin/tools');
  const adminToken=await adminPage.locator('meta[name=csrf-token]').getAttribute('content');
  const form=adminPage.locator('[data-api="admin/domain-dns-service"]');
  const original=await form.evaluate(f=>Object.fromEntries(new FormData(f)));
  const save=async changes=>{const response=await admin.request.post(base+'/api/v1/admin/domain-dns-service',{form:{...original,...changes,csrf:adminToken}});assert.equal(response.status(),200,await response.text());};
  try{
   await save({slug:'domain-review-checker',name:'Domain Review Checker',description:'Review registration and DNS',visible:'0'});
   await page.goto(base+'/');assert.equal(await page.locator('#domain-dns-form').count(),0);await page.goto(base+'/domain-review-checker');assert.ok(await page.locator('#domain-dns-form').isVisible());assert.equal(await page.locator('h1').textContent(),'Domain Review Checker');
   assert.equal((await guest.request.get(base+'/domain-dns-checker')).status(),404);
   await save({enabled:'0'});assert.equal((await guest.request.get(base+'/domain-dns-checker')).status(),404);assert.equal((await guest.request.post(base+'/api/v1/domain-dns',{form:{csrf:token,domain:'example.com',type:'A'}})).status(),404);
   const response=await admin.request.post(base+'/api/v1/admin/domain-dns-service',{form:{...original,slug:'login',csrf:adminToken}});assert.equal(response.status(),422);
  }finally{await save(original);}
  assert.equal((await guest.request.post(base+'/api/v1/admin/domain-dns-service',{form:{...original,csrf:token}})).status(),401);
  assert.deepEqual(errors,[]);console.log('PASS public access, API validation, mobile/desktop, loading, partial failures, escaping, admin settings, slug routing, visibility, disable enforcement, authorization.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
