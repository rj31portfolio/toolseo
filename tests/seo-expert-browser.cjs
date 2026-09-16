const {chromium}=require('../storage/browser-tools/node_modules/playwright-core');
const assert=require('node:assert/strict');
(async()=>{
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const page=await browser.newPage({viewport:{width:1440,height:1000}});const errors=[];page.on('pageerror',e=>errors.push(e.message));
 const base=process.env.EXPERT_TEST_URL;assert(base&&process.env.EXPERT_TEST_PASSWORD);
 const submit=async(form,name)=>{const responsePromise=page.waitForResponse(r=>r.url().endsWith('/api/v1/seo-expert-admin')&&r.request().method()==='POST');const navigation=page.waitForEvent('framenavigated',f=>f===page.mainFrame());await form.getByRole('button',{name,exact:true}).click();const response=await responsePromise;assert.equal(response.ok(),true,'Admin save must succeed');await navigation;await page.waitForLoadState('networkidle');};
 try {
  await page.goto(base+'/');await page.locator('#hire-seo-expert').waitFor();assert.equal(await page.locator('.expert-plan:visible').count(),3);
  await page.selectOption('[data-expert-duration]','6');await page.locator('[data-expert-pricing="6"] [data-plan="growth"]').click();
  const form=page.locator('[data-expert-enquiry]');assert.equal(await form.locator('[name=plan]').inputValue(),'growth');assert.equal(await form.locator('[name=duration]').inputValue(),'6');
  for(const [key,value] of Object.entries({full_name:'Expert Test Client',business_name:'Example Business',website:'https://example.com',phone:'+919876543210',email:'expert-client@example.com',target_location:'Mumbai',target_keywords:'local SEO',current_problem:'Low search visibility',message:'Please review our website.'}))await form.locator(`[name=${key}]`).fill(value);
  await form.getByRole('button',{name:/Send SEO enquiry/}).click();await page.getByRole('button',{name:'Enquiry received',exact:true}).waitFor();await page.getByRole('button',{name:'Close enquiry'}).click();
  await page.setViewportSize({width:390,height:844});await page.locator('#hire-seo-expert').scrollIntoViewIfNeeded();assert(await page.locator('#hire-seo-expert').evaluate(el=>el.scrollWidth<=innerWidth));
  await page.screenshot({path:'storage/reports/seo-expert-mobile.png'});
  await page.goto(base+'/hire-seo-expert');assert.equal(await page.locator('h1').count(),1);
  const denied=await page.request.post(base+'/api/v1/seo-expert-admin',{form:{operation:'export'}});assert(denied.status()>=400);
  await page.goto(base+'/login');await page.locator('[name=email]').fill('expert-admin@example.test');await page.locator('[name=password]').fill(process.env.EXPERT_TEST_PASSWORD);await page.locator('form button.button').first().click();await page.waitForURL('**/dashboard');
  await page.setViewportSize({width:1440,height:1000});await page.goto(base+'/admin/seo-expert');await page.getByRole('link',{name:'Expert Test Client',exact:true}).click();
  const leadForm=page.locator('form').filter({has:page.locator('[name=operation][value=update]')});await leadForm.locator('[name=status]').selectOption('Active');await leadForm.locator('[name=proposal_amount]').fill('14999');await submit(leadForm,'Save enquiry');
  const note=page.locator('form').filter({has:page.locator('[name=operation][value=note]')});await note.locator('[name=body]').fill('Follow up on keyword priorities.');await submit(note,'Add note');
  const payment=page.locator('form').filter({has:page.locator('[name=operation][value=payment]')});await payment.locator('[name=amount]').fill('14999');await payment.locator('[name=payment_state]').selectOption('paid');await submit(payment,'Record payment');
  await page.getByRole('link',{name:'Open SEO client profile'}).click();await page.locator('.expert-timeline').waitFor();assert.equal(await page.locator('.expert-timeline article').count(),3);
  const task=page.locator('form').filter({has:page.locator('[name=operation][value=task_status]')}).first();await task.locator('[name=task_status]').selectOption('Done');await submit(task,'Save task status');
  const rank=page.locator('form').filter({has:page.locator('[name=operation][value=ranking]')});await rank.locator('[name=keyword]').fill('local SEO');await rank.locator('[name=position]').fill('18');await submit(rank,'Save ranking');
  const report=page.locator('form').filter({has:page.locator('[name=operation][value=report]')});await report.locator('[name=title]').fill('Month one review');await report.locator('[name=summary]').fill('Technical fixes reviewed.');await submit(report,'Add report');
  await page.goto(base+'/admin/seo-expert');assert.equal(await page.locator('.expert-chart').count(),6);await page.screenshot({path:'storage/reports/seo-expert-dashboard.png',fullPage:true});
  const download=page.waitForEvent('download');await page.getByRole('button',{name:'Export filtered leads to CSV'}).click();assert.equal((await download).suggestedFilename(),'seo-expert-enquiries.csv');
  await page.setViewportSize({width:390,height:844});assert(await page.locator('.expert-admin').evaluate(el=>el.getBoundingClientRect().width<=innerWidth));assert.deepEqual(errors,[]);console.log('PASS homepage, mobile, enquiry, access control, activation, notes, payment, tasks, rankings, reports, dashboard and CSV');
 } finally {await browser.close();}
})().catch(e=>{console.error(e);process.exit(1);});
