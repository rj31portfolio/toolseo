const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const {execFileSync}=require('child_process');
(async()=>{
 const markup=execFileSync('C:/xampp/php/php.exe',['-r',"require 'includes/bootstrap.php'; $wid=1; require 'dashboard/ai-writing.php';"],{encoding:'utf8'});
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
  const page=await browser.newPage({viewport:{width:1440,height:1000}});const errors=[];page.on('pageerror',error=>errors.push(error.message));
  await page.route('**/api/v1/ai-write',route=>route.fulfill({contentType:'application/json',body:JSON.stringify({success:true,message:'Draft saved',data:{reply:'# Example draft\n\nA complete sample section.'}})}));
  await page.route('**/ai-test-fixture',route=>route.fulfill({contentType:'text/html',body:'<meta name="app-base" content="/ppso"><meta name="csrf-token" content="test">'+markup}));
  await page.goto('http://localhost/ppso/ai-test-fixture');
  await page.addScriptTag({url:'http://localhost/ppso/assets/js/app.js'});
  await page.addScriptTag({url:'http://localhost/ppso/assets/js/workspace.js'});
  for(const css of ['app','refinements','workspace'])await page.addStyleTag({url:'http://localhost/ppso/assets/css/'+css+'.css'});
  await page.locator('[name=topic]').fill('A useful gardening guide');
  for(const tool of ['titles','keywords','blog','article']){
   await page.locator('[name=tool]').selectOption(tool);
   const request=page.waitForRequest('**/api/v1/ai-write');
   await page.locator('#writing-form button').click();
   const sent=await request;if(!sent.postData().includes(tool))throw new Error('Missing tool in request');
   await page.waitForFunction(()=>document.querySelector('#writing-output').textContent.includes('Example draft'));
   await page.waitForFunction(()=>!document.querySelector('#writing-form button').disabled);
  }
  if(await page.locator('.result-document h2').textContent()!=='Example draft')throw new Error('Missing formatted heading');
  await page.getByRole('button',{name:'View Markdown'}).click();
  if(!await page.locator('#writing-output').isVisible())throw new Error('Markdown toggle did not show source');
  await page.getByRole('button',{name:'Hide Markdown'}).click();
  const safe=await page.evaluate(()=>{const preview=renderDraft('# Title\n\n**Bold** [unsafe](javascript:alert(1)) <img src=x onerror=alert(1)>\n\n| Keyword | Intent |\n| --- | --- |\n| gardening | Learn |');return preview.querySelectorAll('img,script,a').length===0&&preview.querySelectorAll('table tbody tr').length===1&&preview.querySelector('strong').textContent==='Bold';});
  if(!safe)throw new Error('Markdown rendering security or table formatting failed');
  await page.screenshot({path:'storage/design-ai-result-1440.png',fullPage:true});
  await page.locator('[data-writing-humanize]').click();
  if(await page.locator('[name=source]').inputValue()!=='# Example draft\n\nA complete sample section.')throw new Error('Humanizer did not preserve the full result');
  if(!await page.locator('[name=source]').isVisible())throw new Error('Source field hidden');
  if(!await page.locator('[name=words]').isDisabled())throw new Error('Humanize length control should be disabled');
  await page.locator('[name=topic]').fill('');
  const request=page.waitForRequest('**/api/v1/ai-write');await page.locator('#writing-form button').click();await request;
  await page.waitForFunction(()=>!document.querySelector('#writing-form button').disabled);
  const download=page.waitForEvent('download');await page.locator('[data-writing-download]').click();if((await download).suggestedFilename()!=='ai-draft.md')throw new Error('Incorrect download name');
  await page.route('**/api/v1/ai-write',route=>route.fulfill({status:503,contentType:'application/json',body:JSON.stringify({success:false,message:'Gemini rejected the API key or its permissions.'})}));
  await page.locator('#writing-form button').click();await page.waitForFunction(()=>document.querySelector('#toast').textContent.includes('rejected'));
  if(await page.locator('[name=source]').inputValue()==='')throw new Error('Failed request lost source');
  await page.locator('[name=tool]').selectOption('blog');
  if(!await page.locator('[name=source]').isDisabled())throw new Error('Unused source should not be submitted');
  if(errors.length)throw new Error(errors.join('\n'));
  console.log('PASS all five writing flows, formatted results, safe Markdown and tables, source toggle, full-result handoff, Markdown download, failure recovery, and no browser JavaScript errors (mock provider).');
 }finally{await browser.close();}
})().catch(error=>{console.error(error.message);process.exit(1);});
