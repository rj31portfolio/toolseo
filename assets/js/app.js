'use strict';
const writingForm=document.getElementById('writing-form');
function updateWritingTool(){
 if(!writingForm)return;
 const humanize=writingForm.elements.tool.value==='humanize';
 document.getElementById('writing-source-label').hidden=!humanize;
 writingForm.elements.source.disabled=!humanize;
 writingForm.elements.source.required=humanize;
 writingForm.elements.topic.required=!humanize;
 const longDraft=['blog','article'].includes(writingForm.elements.tool.value);
 writingForm.elements.words.disabled=!longDraft;
 writingForm.elements.words.closest('label').hidden=!longDraft;
}
writingForm?.elements.tool.addEventListener('change',updateWritingTool);
updateWritingTool();
document.addEventListener('click',async event=>{
 const button=event.target.closest('[data-writing-copy],[data-writing-download],[data-writing-humanize]');
 if(!button)return;
 const output=document.getElementById('writing-output');
 if(output.hidden||!output.textContent.trim()){toast('Generate a draft first.',true);return;}
 const text=output.textContent;
 if(button.hasAttribute('data-writing-copy')){try{await navigator.clipboard.writeText(text);toast('Result copied');}catch{toast('Select and copy the result manually.',true);}}
 if(button.hasAttribute('data-writing-download')){const blob=new Blob([text],{type:'text/markdown;charset=utf-8'});const link=document.createElement('a');link.href=URL.createObjectURL(blob);link.download='ai-draft.md';link.click();setTimeout(()=>URL.revokeObjectURL(link.href),1000);}
 if(button.hasAttribute('data-writing-humanize')){if(text.length>30000){toast('This draft exceeds 30,000 characters. Humanize it in sections.',true);return;}writingForm.elements.tool.value='humanize';updateWritingTool();writingForm.elements.source.value=text;writingForm.elements.source.focus();writingForm.scrollIntoView({behavior:'smooth'});}
});
const base=document.querySelector('meta[name="app-base"]')?.content||'';
const token=document.querySelector('meta[name="csrf-token"]')?.content||'';
function toast(message,error=false){let el=document.getElementById('toast');if(!el){el=document.createElement('div');el.id='toast';el.role='status';document.body.append(el);}el.className='toast'+(error?' error':'');el.textContent=message;el.hidden=false;setTimeout(()=>el.hidden=true,7000);}
async function api(endpoint,data){const response=await fetch(base+'/api/v1/'+endpoint,{method:'POST',body:data,headers:{'X-CSRF-Token':token,'Accept':'application/json'},credentials:'same-origin'});let result;try{result=await response.json();}catch{throw new Error('The server returned an unexpected response. Please try again.');}if(!response.ok||!result.success)throw new Error(result.message||'Request failed');return result;}
document.addEventListener('submit',async event=>{
 const form=event.target;if(!form.matches('[data-api]'))return;event.preventDefault();
 if(form.dataset.busy==='true')return;form.dataset.busy='true';form.setAttribute('aria-busy','true');
 const button=event.submitter||form.querySelector('button'),original=button?.textContent;
 let feedback=form.querySelector('.form-feedback');if(!feedback){feedback=document.createElement('div');feedback.className='form-feedback';feedback.setAttribute('role','status');feedback.setAttribute('aria-live','polite');form.append(feedback);}
 feedback.hidden=false;feedback.className='form-feedback pending';feedback.textContent=form.dataset.api.startsWith('ai')?'Creating your response. This may take up to two minutes.':'Working on your request…';
 const submitted=new FormData(form);if(button){button.disabled=true;button.textContent='Working…';}
 try{
  const result=await api(form.dataset.api,submitted);feedback.className='form-feedback';feedback.textContent=result.message;toast(result.message);
  if(result.data?.redirect){window.location.assign(result.data.redirect);return;}
  if(form.dataset.output){const output=document.getElementById(form.dataset.output);output.textContent=result.data.json||result.data.reply||JSON.stringify(result.data,null,2);output.hidden=false;}
  else if(form.dataset.api==='ai'){const box=document.getElementById('chat');for(const [role,text] of [['user',submitted.get('message')],['assistant',result.data.reply]]){const div=document.createElement('div');div.className='chat-message '+role;div.textContent=text;box.append(div);}if(form.elements.message.value===submitted.get('message'))form.elements.message.value='';}
  else if(form.dataset.reload!=='false')window.location.reload();
 }catch(error){feedback.className='form-feedback error';feedback.textContent=error.message;toast(error.message,true);}
 finally{form.dataset.busy='false';form.setAttribute('aria-busy','false');if(button){button.disabled=false;button.textContent=original;}}
});
document.addEventListener('click',async event=>{const toggle=event.target.closest('[data-toggle-sidebar]');if(toggle){document.getElementById('sidebar')?.classList.toggle('open');toggle.setAttribute('aria-expanded',document.getElementById('sidebar')?.classList.contains('open')?'true':'false');return;}const action=event.target.closest('[data-action]');if(!action)return;if(action.dataset.confirm&&!confirm(action.dataset.confirm))return;const data=new FormData();for(const [key,val] of Object.entries(action.dataset))if(!['action','confirm'].includes(key))data.set(key.replace(/[A-Z]/g,m=>'_'+m.toLowerCase()),val);action.disabled=true;try{const result=await api(action.dataset.action,data);toast(result.message);if(result.data?.redirect)location.assign(result.data.redirect);else location.reload();}catch(error){toast(error.message,true);action.disabled=false;}});
document.querySelector('[data-website-picker]')?.addEventListener('change',event=>{const u=new URL(location.href);u.searchParams.set('website_id',event.target.value);u.searchParams.delete('page');location.assign(u);});
const progress=document.querySelector('[data-crawl-progress]');
if(progress){
 const advance=async()=>{
  try{
   let result;
   if(progress.dataset.crawlCanRun==='1'){
    const data=new FormData();data.set('website_id',progress.dataset.crawlProgress);
    result=await api('crawl-step',data);
   }else{
    const response=await fetch(base+'/api/v1/crawl-progress?website_id='+encodeURIComponent(progress.dataset.crawlProgress));
    result=await response.json();
    if(!response.ok||!result.success)throw new Error(result.message||'Unable to load progress');
   }
   const job=result.data;
   progress.textContent=`${job.status}: ${job.processed} / ${job.max_pages} pages processed${job.error?' — '+job.error:''}`;
   if(['completed','failed'].includes(job.status)){location.reload();return;}
   setTimeout(advance,1500);
  }catch(error){progress.textContent='Audit paused: '+error.message+' Refresh this page to resume.';toast(error.message,true);}
 };
 advance();
}
document.querySelector('[data-copy-schema]')?.addEventListener('click',async()=>{try{await navigator.clipboard.writeText(document.getElementById('schema-output').textContent);toast('Copied JSON-LD');}catch{toast('Select and copy the JSON-LD text manually.',true);}});
document.querySelector('[data-print]')?.addEventListener('click',()=>window.print());

document.querySelector('[data-check-rankings]')?.addEventListener('click',async event=>{
 const button=event.currentTarget,progress=document.getElementById('ranking-progress');
 const ids=JSON.parse(button.dataset.keywords);let completed=0;
 button.disabled=true;button.textContent='Checking rankings…';progress.hidden=false;
 for(const id of ids){
  progress.textContent=`Checking keyword ${completed+1} of ${ids.length}. Searching up to 100 positions. Keep this page open; checking several Google pages can take a few minutes.`;
  const data=new FormData();data.set('website_id',button.dataset.websiteId);data.set('keyword_id',id);
  try{await api('ranking-check',data);completed++;}
  catch(error){progress.textContent=`${completed} of ${ids.length} checks saved. ${error.message} Refresh to view saved results or retry the remaining checks.`;button.disabled=false;button.textContent='Retry remaining checks';button.dataset.keywords=JSON.stringify(ids.slice(completed));return;}
 }
 progress.textContent=`All ${completed} checks saved. Updating results…`;location.reload();
});
document.querySelector('[data-ranking-filter]')?.addEventListener('input',event=>{
 const search=event.target.value.trim().toLowerCase();let visible=0;
 document.querySelectorAll('[data-ranking-row]').forEach(row=>{row.hidden=!row.cells[0].textContent.toLowerCase().includes(search);if(!row.hidden)visible++;});
 document.querySelector('[data-ranking-empty]').hidden=visible!==0;
});
