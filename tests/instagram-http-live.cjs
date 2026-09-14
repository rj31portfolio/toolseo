// Optional live, anonymous metadata -> session token -> binary download check.
const assert=require('assert/strict');
(async()=>{
 const base=process.env.TEST_BASE||'http://localhost/ppso';
 const response=await fetch(base+'/instagram-downloader');assert.equal(response.status,200);
 const html=await response.text(),csrf=html.match(/name="csrf-token" content="([^"]+)"/)?.[1];assert.ok(csrf);
 let cookies=response.headers.getSetCookie().map(cookie=>cookie.split(';')[0]);
 const lookup=await fetch(base+'/api/v1/instagram-downloader',{method:'POST',headers:{Cookie:cookies.join('; ')},body:new URLSearchParams({csrf,url:process.argv[2]||'https://www.instagram.com/p/C/'})});
 const payload=await lookup.json();assert.equal(lookup.status,200,payload.message);assert.ok(payload.success);assert.ok(payload.data.token);
 const refreshed=lookup.headers.getSetCookie().map(cookie=>cookie.split(';')[0]);if(refreshed.length)cookies=refreshed;
 const download=await fetch(base+'/api/v1/instagram-media',{method:'POST',headers:{Cookie:cookies.join('; ')},body:new URLSearchParams({csrf,token:payload.data.token})});
 assert.equal(download.status,200,download.status===200?'':await download.text());assert.match(download.headers.get('content-disposition'),/^attachment;/);
 const bytes=Buffer.from(await download.arrayBuffer());assert.ok(bytes.length>0);assert.equal(bytes.length,Number(download.headers.get('content-length')));
 console.log(`PASS anonymous public endpoint: ${payload.data.type}, ${bytes.length} bytes, ${download.headers.get('content-type')}, attachment download.`);
})().catch(error=>{console.error(error.message);process.exit(1);});
