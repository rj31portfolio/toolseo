const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
  const page=await browser.newPage(),errors=[];
  page.on('pageerror',e=>errors.push(e.message));
  const creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
  const {website_id}=JSON.parse(fs.readFileSync('storage/test-position-display.json','utf8'));
  const base='http://127.0.0.1:8086';
  await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);
  await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
  for(const width of [1440,390]){
   await page.setViewportSize({width,height:1000});
   for(const route of ['keywords','rankings']){
    const response=await page.goto(base+'/'+route+'?website_id='+website_id);
    if(response.status()!==200)throw Error(route+' failed');
    const rows=page.locator('table tbody tr');
    const found=rows.filter({hasText:'Found on page three'}).first();
    if(!(await found.textContent()).includes('#26'))throw Error(route+' missing numeric position');
    if(!(await rows.filter({hasText:'Missing after deeper search'}).first().textContent()).includes('Not found (up to 100)'))throw Error(route+' missing depth explanation');
    if(!(await rows.filter({hasText:'Never checked'}).first().textContent()).includes('Not checked'))throw Error(route+' missing unchecked state');
    if(route==='rankings'){
     if(!(await rows.filter({hasText:'Found on page three'}).last().textContent()).includes('#26'))throw Error('History position missing');
     const ids=JSON.parse(await page.locator('[data-check-rankings]').getAttribute('data-keywords'));
     if(ids.length!==2)throw Error('Old checks must be eligible; complete deep checks must be cached');
    }
    if(await page.locator('body').evaluate(e=>e.scrollWidth>innerWidth+1))throw Error(route+' overflow');
    await page.screenshot({path:'storage/position-fix-'+route+'-'+width+'.png',fullPage:true});
   }
  }
  if(errors.length)throw Error(errors.join('\n'));
  console.log('PASS numeric positions, missing/unchecked labels, history, cache upgrade eligibility, and desktop/mobile keyword and ranking pages');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
