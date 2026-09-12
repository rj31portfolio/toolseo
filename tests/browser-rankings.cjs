const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
  const page=await browser.newPage({viewport:{width:1440,height:1000}}),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  const creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
  const fixture=JSON.parse(fs.readFileSync('storage/test-ranking-fixture.json','utf8'));
  const base='http://127.0.0.1:8086';
  await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);
  await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
  await page.goto(base+'/rankings?website_id='+fixture.website_id);
  await page.route('**/api/v1/ranking-check',route=>route.fulfill({status:503,contentType:'application/json',body:JSON.stringify({success:false,message:'HasData is busy. Please retry later.'})}));
  await page.locator('[data-check-rankings]').click();
  await page.waitForFunction(()=>document.querySelector('#ranking-progress').textContent.includes('Please retry later'));
  if(await page.locator('[data-check-rankings]').isDisabled())throw Error('Retry button disabled after failure');
  await page.unroute('**/api/v1/ranking-check');
  await Promise.all([page.waitForEvent('load',{timeout:120000}),page.locator('[data-check-rankings]').click()]);
  if(!await page.locator('#ranking-table').textContent().then(t=>t.includes('#1')&&t.includes('Live API')))throw Error('Live ranking was not saved/displayed');
  const cached=await page.evaluate(async f=>{
   const d=new FormData();d.set('website_id',f.website_id);d.set('keyword_id',f.keyword_id);
   return await (await fetch('/api/v1/ranking-check',{method:'POST',body:d,headers:{'X-CSRF-Token':document.querySelector('meta[name=csrf-token]').content}})).json();
  },fixture);
  if(!cached.success||cached.data.position!==1)throw Error('Cached daily ranking failed');
  await page.locator('[data-ranking-filter]').fill('unmatched-query');
  if(!await page.locator('[data-ranking-empty]').isVisible())throw Error('Filter empty state missing');
  await page.locator('[data-ranking-filter]').fill('Coffee');
  if(!await page.locator('[data-ranking-row]').isVisible())throw Error('Keyword search failed');
  for(const width of [1440,390]){
   await page.setViewportSize({width,height:1000});
   for(const route of ['rankings','dashboard']){
    await page.goto(base+'/'+route+'?website_id='+fixture.website_id);
    if(await page.locator('body').evaluate(e=>e.scrollWidth>innerWidth+1))throw Error('Overflow '+route+' '+width);
    await page.screenshot({path:'storage/'+route+'-hasdata-'+width+'.png',fullPage:true});
   }
  }
  if(errors.length)throw Error(errors.join('\n'));
  console.log('PASS live ranking button, failure/retry feedback, saved position, daily cache, keyword filter, desktop/mobile ranking and overview layouts');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
