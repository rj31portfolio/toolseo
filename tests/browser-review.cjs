const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
const base=process.env.SEO_TEST_URL||'http://127.0.0.1:8086';
if(!base.startsWith('http://127.0.0.1:8086'))throw Error('Use the isolated review server');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const context=await browser.newContext({viewport:{width:1440,height:1000},acceptDownloads:true});
 const page=await context.newPage();const errors=[],failures=[],inventory=[];let count=0;
 page.on('pageerror',e=>errors.push(e.message));
 try{
  const creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
  await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);
  await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
  const grant=await page.evaluate(async()=>{
   const data=new FormData();data.set('csrf',document.querySelector('meta[name="csrf-token"]').content);data.set('user_id','1');data.set('plan_id','4');data.set('ends_at','2030-01-01');
   return (await fetch('/api/v1/admin/subscription',{method:'POST',body:data})).status;
  });
  if(grant!==200)throw Error('Could not prepare review account plan');
  const routes=['dashboard','websites','audit','pages','keywords','rankings','research','competitors','backlinks','content','tasks','reports','ai-assistant','schema','internal-links','automations','human-services','team','billing','profile','notifications','project-settings','admin','admin/users','admin/plans','admin/subscriptions','admin/payments','admin/coupons','admin/websites','admin/issues','admin/tasks','admin/services','admin/reports','admin/settings','admin/logs'];
  for(const width of [1440,390]){
   await page.setViewportSize({width,height:1000});
   for(const path of routes){
    const response=await page.goto(base+'/'+path+'?website_id=1',{waitUntil:'load'});
    if(response.status()!==200)failures.push(path+' HTTP '+response.status());
    if(await page.locator('body').evaluate(el=>el.scrollWidth>innerWidth+1))failures.push(path+' overflow at '+width);
    if(width===1440)inventory.push({path,buttons:await page.locator('button').allTextContents(),forms:await page.locator('form').evaluateAll(forms=>forms.map(f=>({api:f.dataset.api||f.id||f.action,fields:[...f.elements].map(e=>e.name).filter(Boolean)})))});
    count++;
   }
  }
  await page.setViewportSize({width:1440,height:1000});
  await page.goto(base+'/schema?website_id=1');
  await page.locator('form[data-api=schema] button').click();
  await page.waitForFunction(()=>document.querySelector('#schema-output').textContent.includes('@context'));
  JSON.parse(await page.locator('#schema-output').textContent());count++;
  await page.goto(base+'/tasks?website_id=1');
  const form=page.locator('form[data-api=save]');
  await form.locator('[name=title]').fill('Browser verified task');
  await Promise.all([page.waitForEvent('load'),form.locator('button').click()]);
  if(!await page.getByText('Browser verified task',{exact:true}).count())throw Error('Task creation not visible');count++;
  await page.goto(base+'/reports?website_id=1');
  await Promise.all([page.waitForURL('**/report?**'),page.locator('[data-action=report]').click()]);
  const reportUrl=page.url();
  const download=await Promise.all([page.waitForEvent('download'),page.getByRole('link',{name:/Download PDF/}).click()]);
  const file=await download[0].path();if(!fs.readFileSync(file).subarray(0,4).equals(Buffer.from('%PDF')))throw Error('Invalid downloaded PDF');count++;
  let printed=false;await page.exposeFunction('reportPrinted',()=>{printed=true});await page.evaluate(()=>window.print=()=>window.reportPrinted());
  await page.locator('[data-print]').click();if(!printed)throw Error('Print button did not invoke print');count++;
  await page.screenshot({path:'storage/review-report.png',fullPage:true});
  await page.goto(base+'/billing');
  await page.locator('#checkout-form button').click();await page.waitForFunction(()=>document.querySelector('#toast')?.textContent.includes('configured'));count++;
  await page.goto(base+'/schema?website_id=1');await page.setViewportSize({width:390,height:844});
  await page.locator('[data-toggle-sidebar]').click();if(!await page.locator('#sidebar').evaluate(el=>el.classList.contains('open')))throw Error('Mobile menu did not open');count++;
  fs.writeFileSync('storage/review-browser-results.json',JSON.stringify({count,errors,failures,reportUrl,inventory},null,2));
  if(errors.length||failures.length)throw Error(JSON.stringify({errors,failures}));
  console.log('PASS '+count+' browser checks, including report download and print');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
