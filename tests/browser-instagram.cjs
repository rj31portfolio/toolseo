const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const assert=require('assert/strict'),fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const base=process.env.TEST_BASE||'http://127.0.0.1:8086';
 try{
  const guest=await browser.newContext({viewport:{width:390,height:844}}),page=await guest.newPage(),errors=[];page.on('pageerror',e=>errors.push(e.message));
  await page.goto(base+'/');assert.ok(await page.locator('#instagram-form').isVisible());await page.goto(base+'/instagram-downloader');assert.ok(!page.url().includes('login'));const token=await page.locator('meta[name=csrf-token]').getAttribute('content');
  const endpoint=base+'/api/v1/instagram-downloader';
  assert.equal((await guest.request.get(endpoint)).status(),405);assert.equal((await guest.request.post(endpoint,{form:{url:'https://instagram.com/p/abc/'}})).status(),419);assert.equal((await guest.request.post(endpoint,{form:{csrf:token,url:'https://127.0.0.1/'}})).status(),422);
  assert.equal((await guest.request.post(base+'/api/v1/instagram-media',{form:{csrf:token,token:'forged'}})).status(),410);
  await page.route('**/api/v1/instagram-downloader',async route=>{await new Promise(resolve=>setTimeout(resolve,200));return route.fulfill({json:{success:true,data:{title:'A <img src=x onerror=alert(1)> public post',type:'image',content_kind:'post',downloadable:true,thumbnail:null,notice:'Only the public preview image is available.',token:'fixture'}}});});
  await page.route('**/api/v1/instagram-media',route=>route.fulfill({contentType:'image/png',body:Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAusB9Wl2n9sAAAAASUVORK5CYII=','base64')}));
  await page.locator('#instagram-url').fill('https://www.instagram.com/p/abc/');await page.locator('#instagram-form button').click();assert.ok(await page.locator('#instagram-form button').isDisabled());await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);assert.equal(await page.locator('#instagram-result img').count(),0);assert.equal(await page.locator('#instagram-result .badge').textContent(),'Image post');
  const download=page.waitForEvent('download');await page.locator('#instagram-result button').click();assert.equal((await download).suggestedFilename(),'instagram-image.png');
  await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);
  for(const width of [390,1440]){await page.setViewportSize({width,height:1000});assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth),'No page overflow at '+width);await page.screenshot({path:`storage/instagram-${width}.png`,fullPage:true});}
  await page.unroute('**/api/v1/instagram-downloader');await page.route('**/api/v1/instagram-downloader',route=>route.fulfill({status:502,json:{success:false,message:'Instagram blocked anonymous access. Access controls are not bypassed.'}}));await page.locator('#instagram-form button').click();await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);assert.ok((await page.locator('#instagram-status').textContent()).includes('blocked'));assert.equal(await page.locator('#instagram-result button').count(),0);
  await page.unroute('**/api/v1/instagram-downloader');await page.unroute('**/api/v1/instagram-media');
  const admin=await browser.newContext(),adminPage=await admin.newPage();await adminPage.goto(base+'/admin/tools');const credentials=JSON.parse(fs.readFileSync(process.env.TEST_CREDENTIALS||'storage/test-credentials.json','utf8'));await adminPage.locator('[name=email]').fill(credentials.email);await adminPage.locator('[name=password]').fill(credentials.password);await Promise.all([adminPage.waitForURL('**/dashboard'),adminPage.locator('form button').click()]);await adminPage.goto(base+'/admin/tools');
  const adminToken=await adminPage.locator('meta[name=csrf-token]').getAttribute('content'),original=await adminPage.locator('[data-api="admin/instagram-service"]').evaluate(f=>Object.fromEntries(new FormData(f)));
  const save=async changes=>{const response=await admin.request.post(base+'/api/v1/admin/instagram-service',{form:{...original,...changes,csrf:adminToken}});assert.equal(response.status(),200,await response.text());};
  try{
   await save({slug:'instagram-review',name:'Instagram Review',visible:'0'});await page.goto(base+'/');assert.equal(await page.locator('#instagram-form').count(),0);await page.goto(base+'/instagram-review');assert.ok(await page.locator('#instagram-form').isVisible());assert.equal(await page.locator('#instagram-heading').textContent(),'Instagram Review');assert.equal((await guest.request.get(base+'/instagram-downloader')).status(),404);
   await save({enabled:'0'});assert.equal((await guest.request.get(base+'/instagram-downloader')).status(),404);for(const action of ['instagram-downloader','instagram-media'])assert.equal((await guest.request.post(base+'/api/v1/'+action,{form:{csrf:token}})).status(),404);
   assert.equal((await admin.request.post(base+'/api/v1/admin/instagram-service',{form:{...original,slug:'domain-dns-checker',csrf:adminToken}})).status(),422);
  }finally{await save(original);}
  assert.equal((await guest.request.post(base+'/api/v1/admin/instagram-service',{form:{...original,csrf:token}})).status(),401);assert.deepEqual(errors,[]);console.log('PASS public access, validation, forged token rejection, loading, fixture download, blocked-access errors, escaping, mobile/desktop, admin settings and authorization.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
