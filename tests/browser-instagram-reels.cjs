const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const assert=require('assert/strict');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
  const page=await browser.newPage({viewport:{width:390,height:844}});await page.goto((process.env.TEST_BASE||'http://localhost/ppso')+'/instagram-downloader');
  let mode='preview',wrongFile=false;
  await page.route('**/api/v1/instagram-downloader',route=>route.fulfill({json:{success:true,data:{title:'Public media',content_kind:mode==='post'?'post':'reel',type:mode==='post'?'image':'video',downloadable:mode!=='preview',token:mode==='preview'?undefined:'fixture',thumbnail:null,notice:mode==='preview'?'Only a thumbnail is available.':'Media available.'}}}));
  await page.route('**/api/v1/instagram-media',route=>route.fulfill({contentType:wrongFile||mode==='post'?'image/jpeg':'video/mp4',body:Buffer.from('fixture media bytes')}));
  const run=async()=>{await page.locator('#instagram-url').fill('https://www.instagram.com/'+(mode==='post'?'p':'reel')+'/abc/');await page.locator('#instagram-form button').click();await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);};
  await run();assert.equal(await page.locator('#instagram-result .badge').textContent(),'Reel');assert.equal(await page.locator('#instagram-result button').count(),0);assert.match(await page.locator('#instagram-status').textContent(),/Video unavailable/);
  mode='video';await run();assert.equal(await page.locator('#instagram-result button').textContent(),'Download reel');
  const download=page.waitForEvent('download');await page.locator('#instagram-result button').click();assert.equal((await download).suggestedFilename(),'instagram-reel.mp4');await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);
  wrongFile=true;await page.locator('#instagram-result button').click();await page.waitForFunction(()=>!document.querySelector('#instagram-form button').disabled);assert.match(await page.locator('#instagram-status').textContent(),/expected video file/);
  mode='post';await run();assert.equal(await page.locator('#instagram-result .badge').textContent(),'Image post');assert.equal(await page.locator('#instagram-result button').textContent(),'Download post image');assert.ok(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth));
  console.log('PASS reel preview has no download, reel MP4 download, mismatched image rejection, image-post controls and mobile layout (fixtures).');
 }finally{await browser.close();}
})().catch(error=>{console.error(error);process.exit(1);});
