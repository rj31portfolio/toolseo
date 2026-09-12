const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true,args:['--no-sandbox']});
 const page=await browser.newPage({viewport:{width:1440,height:1000}});const errors=[];page.on('pageerror',e=>errors.push(e.message));
 await page.goto('http://127.0.0.1:8085/',{waitUntil:'networkidle'});await page.screenshot({path:'storage/home-desktop.png',fullPage:true});
 const credentials=JSON.parse(fs.readFileSync('storage/test-credentials.json','utf8'));
 await page.goto('http://127.0.0.1:8085/login');await page.locator('[name=email]').fill(credentials.email);await page.locator('[name=password]').fill(credentials.password);await Promise.all([page.waitForURL('**/dashboard'),page.locator('button[type=submit],form button').first().click()]);
 await page.screenshot({path:'storage/dashboard-desktop.png',fullPage:true});
 for(const path of ['/dashboard','/keywords?website_id=1','/audit?website_id=1','/reports?website_id=1','/admin']){await page.goto('http://127.0.0.1:8085'+path);if(await page.locator('body').evaluate(el=>el.scrollWidth>innerWidth+1))throw new Error('Desktop horizontal overflow '+path);}
 await page.setViewportSize({width:390,height:844});await page.goto('http://127.0.0.1:8085/dashboard');await page.screenshot({path:'storage/dashboard-mobile.png',fullPage:true});
 for(const path of ['/dashboard','/keywords?website_id=1','/audit?website_id=1','/websites','/']){await page.goto('http://127.0.0.1:8085'+path);if(await page.locator('body').evaluate(el=>el.scrollWidth>innerWidth+1)){console.log(await page.locator('body').evaluate(()=>[...document.querySelectorAll('body *')].filter(el=>el.getBoundingClientRect().right>innerWidth+1).map(el=>({tag:el.tagName,cls:el.className,width:el.getBoundingClientRect().width})).slice(0,15)));throw new Error('Mobile horizontal overflow '+path);}}
 await page.screenshot({path:'storage/home-mobile.png',fullPage:true});
 if(errors.length)throw new Error(errors.join('\n'));console.log('PASS desktop/mobile routes, no horizontal overflow, no browser JS errors');await browser.close();
})().catch(e=>{console.error(e);process.exit(1)});
