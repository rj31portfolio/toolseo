(() => {
 'use strict';
 const form=document.getElementById('domain-dns-form');if(!form)return;
 const results=document.getElementById('domain-dns-results'),status=document.getElementById('domain-dns-status'),button=form.querySelector('button');
 const node=(tag,text)=>{const el=document.createElement(tag);if(text!==undefined)el.textContent=String(text);return el;};
 form.addEventListener('submit',async event=>{
  event.preventDefault();if(button.disabled)return;
  const domain=form.elements.domain.value.trim();
  if(!domain||/[\s/:@?#\\]/.test(domain)||!domain.includes('.')){status.textContent='Enter a domain such as example.com, without a URL or path.';return;}
  button.disabled=true;button.textContent='Checking…';results.replaceChildren();results.hidden=false;results.setAttribute('aria-busy','true');status.textContent='Looking up registration and 8 DNS record types…';
  let failed=0;
  await Promise.all(['RDAP','A','AAAA','CNAME','MX','NS','TXT','SOA','CAA'].map(async type=>{
   const card=node('section');card.className='card';card.append(node('h3',type==='RDAP'?'Domain ownership & registration':type+' records'));const body=node('div');body.append(node('p','Loading…'));card.append(body);results.append(card);
   const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),55000);
   try{
    const data=new FormData(form);data.set('domain',domain);data.set('type',type);
    const response=await fetch(form.action,{method:'POST',body:data,signal:controller.signal,headers:{Accept:'application/json'}});
    const payload=await response.json();if(!response.ok||!payload.success)throw new Error(payload.message||'Lookup failed. Please try again.');
    const result=payload.data;body.replaceChildren();
    if(result.fields){const dl=node('dl');Object.entries(result.fields).forEach(([key,value])=>dl.append(node('dt',key),node('dd',value)));body.append(dl);}
    if(result.records?.length){const wrap=node('div');wrap.className='table-wrap';const table=node('table'),head=node('thead'),tr=node('tr');['Name','TTL (seconds)','Value'].forEach(label=>tr.append(node('th',label)));head.append(tr);const tbody=node('tbody');result.records.forEach(record=>{const row=node('tr');[record.name,record.ttl,record.data].forEach(value=>row.append(node('td',value)));tbody.append(row);});table.append(head,tbody);wrap.append(table);body.append(wrap);}
    if(result.message)body.append(node('p',result.message));
   }catch(error){failed++;const message=node('p',error.name==='AbortError'?'Lookup timed out. Please try again.':error instanceof SyntaxError?'The server returned an unexpected response. Please try again.':error.message);message.className='lookup-error';body.replaceChildren(message);}
   finally{clearTimeout(timer);}
  }));
  status.textContent=failed?`Finished for ${domain}. ${failed} lookup(s) failed; available results are shown below. Retry to check again.`:`Checks complete for ${domain}.`;results.setAttribute('aria-busy','false');button.disabled=false;button.textContent='Check domain & DNS';
 });
})();
