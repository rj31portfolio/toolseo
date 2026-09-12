const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const {createCanvas,loadImage}=require('../storage/browser-tools/node_modules/@napi-rs/canvas');
const decode=require('../storage/browser-tools/jsQR');
const fs=require('fs'),assert=require('assert/strict');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try{
  const context=await browser.newContext({viewport:{width:1440,height:1000},permissions:['clipboard-read','clipboard-write']});
  const page=await context.newPage(),errors=[],requests=[];page.on('pageerror',e=>errors.push(e.message));
  const base=process.env.TEST_BASE||'http://127.0.0.1:8086';
  await page.goto(base+'/admin/tools?tool=qr');assert.ok(page.url().includes('/login'));
  const creds=JSON.parse(fs.readFileSync('storage/review-credentials.json','utf8'));
  await page.locator('[name=email]').fill(creds.email);await page.locator('[name=password]').fill(creds.password);await Promise.all([page.waitForURL('**/dashboard'),page.locator('form button').click()]);
  await page.goto(base+'/admin/tools?tool=qr');assert.equal(await page.locator('#local-tool option').count(),24);
  page.on('request',r=>requests.push(r.url()));
  async function run(id,values){await page.locator('#local-tool').evaluate((el,id)=>{el.value=id;el.dispatchEvent(new Event('change'));},id);for(const [k,v]of Object.entries(values)){const el=page.locator('#local-fields [name='+k+']');if(await el.evaluate(e=>e.tagName==='SELECT'))await el.selectOption(v);else await el.fill(v);}await page.locator('#local-form [type=submit]').click();await page.waitForFunction(()=>!document.querySelector('#local-form [type=submit]').disabled);assert.ok(!await page.locator('#local-status').evaluate(e=>e.classList.contains('error')),id+': '+await page.locator('#local-status').textContent());return page.locator('#local-output').textContent();}
  async function file(){const wait=page.waitForEvent('download');await page.locator('#local-download').click();const d=await wait;const failure=await d.failure();if(failure){await page.screenshot({path:'storage/test-no-api-failure.png',fullPage:true});throw Error(d.suggestedFilename()+': '+failure+' URL '+d.url());}return {name:d.suggestedFilename(),bytes:fs.readFileSync(await d.path())};}
  const xml=await run('sitemap',{urls:'https://example.com/a?x=1&y=2\nhttps://example.com/a?x=1&y=2',lastmod:'2026-09-12'});assert.ok(xml.includes('&amp;'));assert.equal(await page.evaluate(s=>new DOMParser().parseFromString(s,'text/xml').querySelectorAll('url').length,xml),1);assert.equal((await file()).name,'sitemap.xml');
  assert.ok((await run('robots',{agents:'*',allow:'/public/',disallow:'/',sitemaps:'https://example.com/sitemap.xml'})).includes('Disallow: /'));assert.ok((await page.locator('#local-status').textContent()).includes('Warning'));
  assert.equal(JSON.parse(await run('schema',{schemaType:'Article',json:'{"name":"Sample"}'}))['@type'],'Article');
  assert.ok((await run('meta',{topic:'Fresh bread',brand:'Bakery',summary:'Freshly baked bread every morning.',cta:'Order today.'})).includes('<title>Fresh bread | Bakery</title>'));
  await run('serp',{url:'https://example.com',title:'<img src=x onerror=alert(1)>',description:'Description'});assert.equal(await page.locator('#local-preview img').count(),0);assert.ok(await page.locator('.local-serp').isVisible());
  assert.ok((await run('score',{html:'<html><head><title>A useful page title with enough characters</title><meta name="description" content="'+ 'A'.repeat(90)+'"><meta name="viewport" content="width=device-width"><link rel="canonical" href="https://example.com/"></head><body><h1>Title</h1><h2>Subtitle</h2><img src="https://example.invalid/tracker" alt=""><iframe src="https://example.invalid/frame"></iframe><script>throw Error("executed")</script><p>'+ 'word '.repeat(310)+'</p></body></html>'})).includes('100/100'));
  assert.ok((await run('density',{text:'red blue red blue red',phrase:'red blue',ngram:'2'})).includes('2 occurrences | 50.00%'));
  assert.ok((await run('counter',{text:'Hello world! 😀'})).includes('Words: 2'));
  assert.equal(await run('slug',{text:'Café & Fresh Bread',separator:'-'}),'cafe-fresh-bread');
  const utm=new URL(await run('utm',{url:'https://example.com/?x=1#part',source:'email',medium:'newsletter',campaign:'Summer sale'}));assert.equal(utm.searchParams.get('utm_campaign'),'Summer sale');assert.equal(utm.hash,'#part');
  assert.equal(await run('whatsapp',{phone:'+91 9876543210',message:'Hi & hello'}),'https://wa.me/919876543210?text=Hi%20%26%20hello');
  assert.deepEqual(JSON.parse(await run('json',{json:'{"b":[1,2],"a":true}'})),{b:[1,2],a:true});
  const js=await run('minify',{language:'javascript',source:'const url = "https://example.com/a//b";\nconst regex = /a\\/b/;\nfunction f() { return\n { x: 1 }; }'});assert.ok(js.includes('https://example.com/a//b'));assert.ok(js.includes('return;'));
  const css=await run('minify',{language:'css',source:'/* comment */ .a { width: calc(100% - 20px); color: #ffffff; }'});assert.ok(css.includes('calc(100% - 20px)'));assert.ok(css.length<74);
  const html=await run('minify',{language:'html',source:'<!doctype html><!-- comment --><pre> a  b\n c </pre><p class="word">Hello <b>world</b> !</p>'});assert.ok(!html.includes('comment'));assert.ok(html.includes(' a  b\n c '));assert.ok(html.includes('Hello <b>world</b> !'));
  assert.equal(await run('canonical',{url:'https://example.com/?a=1&b=2#part'}),'<link rel="canonical" href="https://example.com/?a=1&amp;b=2">');
  assert.ok((await run('hreflang',{})).includes('hreflang="x-default"'));
  const og=await run('og',{url:'https://example.com',title:'Title " & <script>',description:'Description',imageUrl:'https://example.com/image.png',siteName:'Example'});assert.ok(og.includes('&lt;script&gt;'));
  assert.ok((await run('redirect',{})).includes('RewriteRule "^old-page$"'));
  assert.ok((await run('redirect',{server:'nginx'})).includes('location = "/old-page"'));
  assert.ok((await run('redirect',{redirects:'/old%20page https://example.com/new'})).includes('"^old page$"'));
  await assert.rejects(()=>run('json',{json:'{"id":9007199254740993}'}));
  assert.equal(JSON.parse(await run('business',{name:'Bakery',url:'https://example.com',phone:'+919876543210',street:'1 Main St',city:'Pune',region:'MH',postal:'411001',country:'IN'})).address.addressCountry,'IN');
  assert.equal(JSON.parse(await run('faq',{})).mainEntity.length,1);
  await run('qr',{text:'Hello world https://example.com/'});const qr=await loadImage((await file()).bytes),qrc=createCanvas(qr.width,qr.height),qctx=qrc.getContext('2d');qctx.drawImage(qr,0,0);assert.equal(decode(qctx.getImageData(0,0,qr.width,qr.height).data,qr.width,qr.height).data,'Hello world https://example.com/');
  const src=createCanvas(160,80),ctx=src.getContext('2d');ctx.fillStyle='#ff3030';ctx.fillRect(0,0,160,80);ctx.fillStyle='#209060';ctx.fillRect(0,0,80,80);const buffer=src.toBuffer('image/png');
  for(const id of ['favicon','compress','resize','convert']){await page.locator('#local-tool').evaluate((el,id)=>{el.value=id;el.dispatchEvent(new Event('change'));},id);await page.locator('[name=image]').setInputFiles({name:'sample.png',mimeType:'image/png',buffer});if(id==='resize'){await page.locator('[name=width]').fill('200');await page.locator('[name=height]').fill('100');}await page.locator('#local-form [type=submit]').click();await page.waitForFunction(()=>!document.querySelector('#local-download').disabled);const d=await file();if(id==='favicon'){assert.equal(d.bytes.readUInt16LE(2),1);assert.equal(d.bytes.readUInt32LE(18),22);}else{const img=await loadImage(d.bytes);assert.equal(img.width,id==='resize'?200:160);} }
  for(const mime of ['image/png','image/jpeg','image/webp']){await page.locator('[name=format]').selectOption(mime);await page.locator('#local-form [type=submit]').click();await page.waitForFunction(()=>!document.querySelector('#local-download').disabled);const d=await file();assert.equal((await loadImage(d.bytes)).height,80);}
  await page.screenshot({path:'storage/test-no-api-desktop.png',fullPage:true});
  await page.setViewportSize({width:390,height:844});await page.waitForFunction(()=>document.querySelector('#sidebar').getBoundingClientRect().right<=0);assert.equal(await page.evaluate(()=>document.body.scrollWidth>innerWidth+1),false);await page.screenshot({path:'storage/test-no-api-mobile.png',fullPage:true});
  await run('canonical',{url:'https://example.com'});await page.locator('#local-copy').click();assert.ok((await page.evaluate(()=>navigator.clipboard.readText())).includes('canonical'));await page.locator('[name=url]').fill('https://example.org');assert.ok(await page.locator('#local-download').isDisabled());
  for(const [id,values]of [['json',{json:'{invalid'}],['sitemap',{urls:'https://a.example/\nhttps://b.example/'}],['hreflang',{alternates:'en https://example.com\nen https://example.org'}],['faq',{questions:'[]'}],['minify',{language:'javascript',source:'function {'}]]){await assert.rejects(()=>run(id,values));assert.ok(await page.locator('#local-download').isDisabled());}
  assert.deepEqual(requests.filter(u=>u!==base+'/assets/js/local-minifier.js'&&u!==base+'/assets/images/favicon.svg'),[],'Unexpected tool network request');
  await page.goto(base+'/tools/qr?website_id=0');assert.equal(await page.locator('#local-tool option').count(),24);assert.equal(await page.locator('.welcome-banner').count(),0);
  assert.deepEqual(errors,[]);console.log('PASS: all 24 tools, local worker minifiers, decoded QR, image formats and ICO bytes, copy/download, validation, no processing network requests, admin/user routes, no-site access, mobile layout.');
 }finally{await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
