'use strict';
document.querySelectorAll('[data-local-hours]').forEach(row=>{const state=row.querySelector('[data-hours-state]');const update=()=>row.querySelectorAll('[data-hours-time]').forEach(input=>input.disabled=state.value!=='open');state.addEventListener('change',update);update();});
document.querySelector('[data-local-schema]')?.addEventListener('click',async event=>{
 const form=document.getElementById('local-profile-form'),button=event.currentTarget,feedback=form.querySelector('[data-local-schema-feedback]');
 if(!form.reportValidity())return;button.disabled=true;feedback.hidden=false;feedback.className='form-feedback pending';feedback.textContent='Building your schema draft…';
 try{const result=await api('local-seo-schema',new FormData(form));document.getElementById('local-schema-draft').textContent=result.data.reply;document.querySelector('[data-local-schema-preview]').hidden=false;feedback.className='form-feedback';feedback.textContent='Schema draft ready. No audit was saved.';}
 catch(error){feedback.className='form-feedback error';feedback.textContent=error.message;}
 finally{button.disabled=false;}
});
document.addEventListener('click',async event=>{
 const button=event.target.closest('[data-local-copy],[data-local-download]');if(!button)return;
 const output=document.getElementById(button.dataset.localCopy||button.dataset.localDownload);if(!output||!output.textContent.trim()){toast('Generate schema first.',true);return;}
 if(button.dataset.localCopy){try{await navigator.clipboard.writeText(output.textContent);toast('JSON-LD copied');}catch{output.focus();const range=document.createRange();range.selectNodeContents(output);const selection=window.getSelection();selection.removeAllRanges();selection.addRange(range);toast('JSON-LD selected. Use your device’s copy command.');}return;}
 const url=URL.createObjectURL(new Blob([output.textContent],{type:'application/ld+json;charset=utf-8'}));const link=document.createElement('a');link.href=url;link.download='local-business.jsonld';link.click();setTimeout(()=>URL.revokeObjectURL(url),1000);
});
if(location.hash==='#local-seo-form')document.getElementById('local-seo-form')?.setAttribute('open','');
document.querySelectorAll('a[href="#local-seo-form"]').forEach(link=>link.addEventListener('click',()=>document.getElementById('local-seo-form')?.setAttribute('open','')));
