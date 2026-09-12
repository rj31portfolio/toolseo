const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const fs=require('fs');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
 const page=await browser.newPage({viewport:{width:1440,height:1000}});const errors=[],failures=[];
 page.on('pageerror',e=>errors.push(e.message));
 const base='http://127.0.0.1:8086',creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
 await page.goto(base+'/login');await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);
 await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
 const routes=process.env.DESIGN_BEFORE?['dashboard']:['dashboard','services','local-seo','sitemap-generator','robots-generator','websites','audit','pages','keywords','rankings','research','competitors','backlinks','content','tasks','reports','ai-assistant','schema','internal-links','automations','human-services','team','billing','profile','notifications','project-settings','admin','admin/settings'];
 for(const width of (process.env.DESIGN_BEFORE?[1440]:[1440,390])){
 await page.setViewportSize({width,height:1000});
 for(const route of routes){const r=await page.goto(base+'/'+route+'?website_id=1');if(r.status()!==200)failures.push(route+': '+r.status());if(await page.evaluate(()=>document.body.scrollWidth>innerWidth+1))failures.push(route+' overflow '+width);
 if(['dashboard','services','ai-assistant','human-services','rankings'].includes(route))await page.screenshot({path:'storage/design-'+(process.env.DESIGN_BEFORE?'before-':'')+route+'-'+width+'.png',fullPage:true});}
 }
 if(!process.env.DESIGN_BEFORE){
  await page.goto(base+'/services?website_id=1');
  await page.locator('[data-service-filter="Create"]').click();if(await page.locator('[data-service-group]:visible').count()!==6)failures.push('Create filter');
  await page.locator('[data-service-search]').fill('unmatched xyz');if(!await page.locator('[data-service-empty]').isVisible())failures.push('Service empty state');
  await page.locator('[data-service-search]').fill('');await page.locator('[data-service-filter="All tools"]').click();if(await page.locator('[data-service-group]:visible').count()!==19)failures.push('All tools filter');
  await page.goto(base+'/human-services?website_id=1');await page.locator('[data-select-service="Technical SEO"]').click();if(await page.locator('[name=service]').inputValue()!=='Technical SEO')failures.push('Expert service selection');
  await page.locator('[data-toggle-sidebar]').click();await page.locator('[data-nav-search]').fill('rankings');if(await page.locator('.nav-item:visible').count()!==1)failures.push('Navigation search');
  await page.locator('[data-nav-search]').fill('');await page.keyboard.press('Escape');if(await page.locator('[data-close-sidebar]').isVisible())failures.push('Mobile menu close');
  await page.goto(base+'/ai-assistant?website_id=1');await page.locator('[data-writing-tool="humanize"]').click();if(!await page.locator('[name=source]').isVisible())failures.push('Humanize tool card');
  await page.locator('[data-writing-tool="blog"]').click();if(await page.locator('[name=tool]').inputValue()!=='blog')failures.push('Blog tool card');
  await page.locator('.assistant-chat summary').click();if(!await page.locator('form[data-api=ai]').isVisible())failures.push('Assistant disclosure');
 }
 for(const route of ['','features','pricing','seo-tools','how-it-works','login']){const r=await page.goto(base+'/'+route);if(r.status()!==200)failures.push(route+': '+r.status());if(await page.evaluate(()=>document.body.scrollWidth>innerWidth+1))failures.push(route+' public overflow');}
 if(errors.length||failures.length)throw Error(JSON.stringify({errors,failures}));
 console.log('PASS responsive workspace and public routes; no horizontal overflow or JavaScript errors.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e.message);process.exit(1);});
