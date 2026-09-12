const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs'),assert=require('assert/strict');
(async()=>{const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});try{
 const page=await browser.newPage({viewport:{width:1440,height:1000}}),errors=[];page.on('pageerror',e=>errors.push(e.message));const base='http://127.0.0.1:8086';
 const creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
 for(const route of ['/services','/admin/tools']){
  await page.goto(base+route);const cards=page.locator('.service-card');const links=await cards.evaluateAll(els=>els.map(e=>e.getAttribute('href')).filter(h=>h.includes('/tools/')||h.includes('?tool=')));assert.equal(links.length,24);assert.equal(await page.getByText('No-API tools',{exact:true}).count(),0);
  await page.locator('[data-service-filter="Image Tools"]').click();assert.equal(await page.locator('.service-card:visible').count(),4);assert.equal(await page.locator('[data-service-section]:visible').count(),1);
  await page.locator('[data-service-search]').fill('Favicon');assert.equal(await page.locator('.service-card:visible').count(),1);await page.locator('.service-card:visible').click();assert.equal(await page.locator('#local-title').textContent(),'Favicon Generator');assert.equal(await page.locator('.local-toolbar').isVisible(),false);
  for(const link of links){const r=await page.goto(base+link);assert.equal(r.status(),200,link);assert.ok(await page.locator('#local-title').textContent());assert.equal(await page.locator('.local-toolbar').isVisible(),false);}
  await page.goto(base+route);await page.screenshot({path:'storage/test-service-cards-'+(route==='/services'?'user':'admin')+'.png',fullPage:true});await page.setViewportSize({width:390,height:844});await page.waitForFunction(()=>document.querySelector('#sidebar').getBoundingClientRect().right<=0);assert.equal(await page.evaluate(()=>document.body.scrollWidth>innerWidth+1),false);await page.screenshot({path:'storage/test-service-cards-mobile.png',fullPage:true});await page.setViewportSize({width:1440,height:1000});
 }
 await page.goto(base+'/tools/slug?website_id=0');await page.locator('#local-fields [name=text]').fill('Hello card tools');await page.locator('#local-form [type=submit]').click();assert.equal(await page.locator('#local-output').textContent(),'hello-card-tools');
 assert.deepEqual(errors,[]);console.log('PASS: 24 named cards, categories, search, 48 user/admin tool links, direct forms, generation and mobile layout.');
}finally{await browser.close();}})().catch(e=>{console.error(e);process.exit(1);});
