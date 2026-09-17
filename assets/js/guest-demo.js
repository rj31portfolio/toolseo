'use strict';
window.ZentroDemo=(()=>{
 const base=document.querySelector('meta[name="app-base"]')?.content||'';
 const token=document.querySelector('meta[name="csrf-token"]')?.content||'';
 function paint(tool,data){document.querySelectorAll('[data-demo-quota="'+tool+'"]').forEach(el=>{
  el.replaceChildren();const p=document.createElement('p');p.textContent=data.signed_in?'You are signed in. Keep using this demo.':data.remaining>0?data.remaining+' of 3 free tries remaining.':'Your 3 free tries are complete. Log in to continue.';el.append(p);
  if(!data.signed_in){for(const [path,label] of [['/login','Log in'],['/register','Create free account']]){const a=document.createElement('a');a.href=base+path;a.textContent=label;a.className='button secondary small-button';el.append(a);}}
 });}
 async function call(tool,operation){const data=new FormData();data.set('tool',tool);data.set('operation',operation);const response=await fetch(base+'/api/v1/guest-demo',{method:'POST',credentials:'same-origin',headers:{'X-CSRF-Token':token},body:data});const body=await response.json();if(!response.ok||!body.success){if(response.status===401)paint(tool,{remaining:0,signed_in:false});throw Error(body.message||'Unable to check demo access. Please retry.');}paint(tool,body.data);return body.data;}
 document.addEventListener('DOMContentLoaded',async()=>{for(const tool of new Set([...document.querySelectorAll('[data-demo-quota]')].map(el=>el.dataset.demoQuota))){try{await call(tool,'status');}catch{}}});
 return {use:tool=>call(tool,'use')};
})();
