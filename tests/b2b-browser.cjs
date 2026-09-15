const { chromium } = require('../storage/browser-tools/node_modules/playwright-core');
const assert = require('node:assert/strict');
(async () => {
 const browser = await chromium.launch({executablePath: process.env.B2B_CHROME || 'C:/Program Files/Google/Chrome/Application/chrome.exe', headless: true});
 try {
  const page = await browser.newPage({viewport: {width: 1440,height: 1000}});
  const errors=[];page.on('pageerror', error=>errors.push(error.message));
  const base=process.env.B2B_TEST_URL;assert(base&&process.env.B2B_TEST_PASSWORD,'Requires isolated B2B test runner');
  await page.goto(base+'/');
  const demo=page.locator('[data-lead-demo]');await demo.locator('[name=keyword]').fill('Packaging');await demo.locator('[name=location]').fill('Mumbai');await demo.getByRole('button',{name:'Find Leads'}).click();
  await page.locator('[data-lead-demo-results] tbody tr').first().waitFor();assert(await page.locator('[data-lead-demo-results] tbody tr').count()<=5);
  await page.setViewportSize({width:390,height:844});await page.locator('#b2b-lead-finder').scrollIntoViewIfNeeded();
  assert(await page.locator('#b2b-lead-finder').evaluate(el=>el.getBoundingClientRect().width<=window.innerWidth));
  await page.screenshot({path:'storage/reports/b2b-mobile-review.png'});
  await page.goto(base+'/login');await page.locator('[name=email]').fill('admin@example.test');await page.locator('[name=password]').fill(process.env.B2B_TEST_PASSWORD);await page.locator('form button[type=submit], form button.button').first().click();await page.waitForURL('**/dashboard');
  await page.setViewportSize({width:1440,height:1000});await page.goto(base+'/admin/b2b-leads');
  const importer=page.locator('form').filter({has:page.locator('input[name=csv]')});
  await importer.locator('[name=provenance]').fill('Isolated browser test authorization');await importer.locator('[name=authorized]').check();
  await importer.locator('[name=csv]').setInputFiles({name:'leads.csv',mimeType:'text/csv',buffer:Buffer.from('business_name,category,city,state\nBrowser Fixture,Packaging,Mumbai,Maharashtra\n')});
  await importer.getByRole('button',{name:'Import leads'}).click();await page.getByText('1 leads imported; 0 duplicates skipped.',{exact:true}).waitFor();
  await page.getByRole('checkbox',{name:'Select Browser Fixture',exact:true}).check();await page.locator('#lead-bulk').getByRole('button',{name:'Apply to selected'}).click();await page.getByText('Selected leads updated.',{exact:true}).waitFor();
  const record=page.locator('#lead-bulk tbody tr').filter({hasText:'Browser Fixture'});assert((await record.textContent()).includes('★'));
  await record.getByRole('link',{name:'View / edit'}).click();await page.locator('#lead-details').waitFor();
  await page.screenshot({path:'storage/reports/b2b-admin-review.png',fullPage:true});
  await page.setViewportSize({width:390,height:844});assert(await page.locator('#lead-details').evaluate(el=>el.getBoundingClientRect().width<=window.innerWidth));
  assert.deepEqual(errors,[]);console.log('PASS browser: demo, mobile, login, CSV import, bulk favorite, detail view; no JavaScript errors');
 } finally {await browser.close();}
})().catch(error=>{console.error(error);process.exitCode=1;});
