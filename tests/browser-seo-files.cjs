const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
 const context=await browser.newContext({viewport:{width:1440,height:1000}});await context.grantPermissions(['clipboard-read','clipboard-write']);const page=await context.newPage(),errors=[];page.on('pageerror',e=>errors.push(e.message));
 const base='http://127.0.0.1:8086',creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
 await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
 for(const route of ['sitemap-generator','robots-generator']){
  const response=await page.goto(base+'/'+route+'?website_id=1');if(response.status()!==200)throw Error('Generator route failed');
  if(route==='sitemap-generator'){
   const domain=(await page.locator('[name=urls]').inputValue()).trim();const load=page.locator('[data-load-crawl]');if(await load.isEnabled()){await page.locator('[name=urls]').fill('');await load.click();if(!(await page.locator('[name=urls]').inputValue()).trim())throw Error('Crawled-page import failed');}await page.locator('[name=urls]').fill(domain+'\n'+domain+'?a=1&b=2\n'+domain);
  }else{await page.locator('[name=disallow]').fill('/');if(!await page.locator('[data-block-all]').isVisible())throw Error('Missing whole-site warning');await page.locator('[name=disallow]').fill('/private/');await page.locator('[name=allow]').fill('/private/public/');}
  await page.locator('form[data-api] button[type=submit],form[data-api] > button.button:not([type=button])').click();
  await page.waitForFunction(()=>!document.querySelector('#seo-file-output').hidden);
  const text=await page.locator('#seo-file-output').textContent(),name=route==='sitemap-generator'?'sitemap.xml':'robots.txt';
  if(route==='sitemap-generator'){const valid=await page.evaluate(text=>{const doc=new DOMParser().parseFromString(text,'application/xml');return !doc.querySelector('parsererror')&&doc.getElementsByTagName('url').length===2;},text);if(!valid)throw Error('Invalid XML result');}
  else if(!text.includes('Disallow: /private/')||!text.includes('Allow: /private/public/'))throw Error('Missing robots rules');
  await page.locator('[data-file-copy]').click();await page.waitForFunction(async expected=>(await navigator.clipboard.readText())===expected,text);
  const download=page.waitForEvent('download');await page.locator('[data-file-download]').click();const file=await download;if(file.suggestedFilename()!==name||fs.readFileSync(await file.path(),'utf8')!==text)throw Error('Downloaded content mismatch');
  await page.screenshot({path:'storage/design-'+route+'-result.png',fullPage:true});
  await page.setViewportSize({width:390,height:844});if(await page.evaluate(()=>document.body.scrollWidth>innerWidth+1))throw Error('Mobile overflow');await page.setViewportSize({width:1440,height:1000});
 }
 await page.goto(base+'/sitemap-generator?website_id=1');await page.locator('[name=urls]').fill('https://wrong.example/');await page.locator('form[data-api] > button.button:not([type=button])').click();await page.waitForSelector('.form-feedback.error');if(await page.locator('[name=urls]').inputValue()!=='https://wrong.example/')throw Error('Invalid input lost');
 const csrf=await page.locator('meta[name=csrf-token]').getAttribute('content');
 const forged=await page.evaluate(async()=>{const data=new FormData();data.set('website_id','1');data.set('agents','*');return (await fetch('/api/v1/generate-robots',{method:'POST',body:data})).status;});if(forged!==419)throw Error('Missing CSRF protection');
 const denied=await page.evaluate(async csrf=>{const data=new FormData();data.set('website_id','999999');data.set('urls','https://example.com/');return (await fetch('/api/v1/generate-sitemap',{method:'POST',body:data,headers:{'X-CSRF-Token':csrf}})).status;},csrf);if(denied!==404)throw Error('Missing project protection');
 if(errors.length)throw Error(errors.join('\n'));console.log('PASS both real generator APIs, XML parsing, robots rules, copy/download content, mobile layout, validation and project protection.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e.message);process.exit(1);});
