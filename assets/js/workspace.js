'use strict';
document.querySelector('[data-load-crawl]')?.addEventListener('click',()=>{
 const field=document.querySelector('[name="urls"]'),saved=document.querySelector('[data-crawl-urls]').value;
 const merged=[...new Set((field.value+'\n'+saved).split(/\r?\n/).map(line=>line.trim()).filter(Boolean))];
 if(merged.length>1000){toast('The combined list exceeds 1,000 URLs. Remove some URLs before adding the crawled pages.',true);return;}
 field.value=merged.join('\n');toast('Crawled URLs added. Review your list before generating.');
});
const disallowField=document.querySelector('[name="disallow"]');
disallowField?.addEventListener('input',()=>{document.querySelector('[data-block-all]').hidden=!disallowField.value.split(/\r?\n/).some(line=>line.trim()==='/');});
document.addEventListener('click',async event=>{
 const button=event.target.closest('[data-file-copy],[data-file-download]');if(!button)return;
 const output=document.getElementById('seo-file-output');if(!output||output.hidden||!output.textContent.trim()){toast('Generate your file first.',true);return;}
 if(button.hasAttribute('data-file-copy')){try{await navigator.clipboard.writeText(output.textContent);toast('File copied');}catch{output.focus();const selection=window.getSelection(),range=document.createRange();range.selectNodeContents(output);selection.removeAllRanges();selection.addRange(range);toast('File selected. Use your device’s copy command.');}return;}
 const name=button.dataset.fileDownload,url=URL.createObjectURL(new Blob([output.textContent],{type:name.endsWith('.xml')?'application/xml;charset=utf-8':'text/plain;charset=utf-8'}));const link=document.createElement('a');link.href=url;link.download=name;link.click();setTimeout(()=>URL.revokeObjectURL(url),1000);
});
// Build formatted output with DOM nodes only; provider HTML is never executed.
function appendInline(parent,text){
 const pattern=/(\*\*([^*]+)\*\*|`([^`]+)`|\[([^\]]+)\]\((https?:\/\/[^\s)]+)\))/g;let start=0,match;
 while((match=pattern.exec(text))){parent.append(document.createTextNode(text.slice(start,match.index)));let node;
  if(match[2]){node=document.createElement('strong');node.textContent=match[2];}
  else if(match[3]){node=document.createElement('code');node.textContent=match[3];}
  else{node=document.createElement('a');node.textContent=match[4];node.href=match[5];node.target='_blank';node.rel='noopener noreferrer';}
  parent.append(node);start=pattern.lastIndex;
 }parent.append(document.createTextNode(text.slice(start)));
}
function renderDraft(text){
 const root=document.createElement('div');root.className='result-document';let paragraph=[],list=null,code=null;
 const flush=()=>{if(paragraph.length){const p=document.createElement('p');appendInline(p,paragraph.join(' '));root.append(p);paragraph=[];}};
 const lines=text.replace(/\r\n/g,'\n').split('\n');
 const cells=line=>line.trim().replace(/^\|/,'').replace(/\|$/,'').split('|').map(cell=>cell.trim());
 for(let index=0;index<lines.length;index++){
  const line=lines[index];
  if(/^\s*```/.test(line)){flush();list=null;if(code){root.append(code);code=null;}else code=document.createElement('pre');continue;}
  if(code){code.append(document.createTextNode(line+'\n'));continue;}
  if(line.includes('|')&&index+1<lines.length&&cells(lines[index+1]).every(cell=>/^:?-{3,}:?$/.test(cell))){
   flush();list=null;const wrap=document.createElement('div');wrap.className='table-wrap';const table=document.createElement('table'),head=document.createElement('thead'),tr=document.createElement('tr');
   for(const cell of cells(line)){const th=document.createElement('th');appendInline(th,cell);tr.append(th);}head.append(tr);table.append(head);const body=document.createElement('tbody');index++;
   while(index+1<lines.length&&lines[index+1].includes('|')&&lines[index+1].trim()){index++;const row=document.createElement('tr');for(const cell of cells(lines[index])){const td=document.createElement('td');appendInline(td,cell);row.append(td);}body.append(row);}
   table.append(body);wrap.append(table);root.append(wrap);continue;
  }
  if(!line.trim()){flush();list=null;continue;}
  const heading=line.match(/^(#{1,6})\s+(.+)$/),bullet=line.match(/^\s*([-*+]\s+|\d+[.)]\s+)(.+)$/);
  if(heading){flush();list=null;const h=document.createElement('h'+Math.min(heading[1].length+1,4));appendInline(h,heading[2]);root.append(h);}
  else if(bullet){flush();const tag=/^\d/.test(bullet[1])?'OL':'UL';if(!list||list.tagName!==tag){list=document.createElement(tag);root.append(list);}const li=document.createElement('li');appendInline(li,bullet[2]);list.append(li);}
  else if(/^>\s?/.test(line)){flush();list=null;const quote=document.createElement('blockquote');appendInline(quote,line.replace(/^>\s?/,''));root.append(quote);}
  else if(/^\s*([-*_])\1{2,}\s*$/.test(line)){flush();root.append(document.createElement('hr'));list=null;}
  else{list=null;paragraph.push(line);}
 }flush();if(code)root.append(code);return root;
}
function observeDraft(source){
 if(!source)return;let preview,lastText='';
 const update=()=>{const text=source.textContent;if(source.hidden||!text.trim()||text===lastText||(source.id==='brief-output'&&text.startsWith('No brief saved')))return;lastText=text;
  if(!preview){preview=document.createElement('section');preview.className='result-preview';preview.setAttribute('aria-label','Formatted result');source.before(preview);source.classList.add('result-source');}
  const toolbar=document.createElement('div');toolbar.className='result-toolbar';
  const count=document.createElement('span');count.textContent='Draft · '+text.trim().split(/\s+/).length.toLocaleString()+' words';
  const toggle=document.createElement('button');toggle.type='button';toggle.textContent=source.classList.contains('show-source')?'Hide Markdown':'View Markdown';toggle.setAttribute('aria-expanded',String(source.classList.contains('show-source')));toggle.addEventListener('click',()=>{const show=source.classList.toggle('show-source');toggle.textContent=show?'Hide Markdown':'View Markdown';toggle.setAttribute('aria-expanded',String(show));});
  toolbar.append(count,toggle);preview.replaceChildren(toolbar,renderDraft(text));document.querySelector('[data-result-placeholder]')?.setAttribute('hidden','');
 };new MutationObserver(update).observe(source,{childList:true,characterData:true,subtree:true,attributes:true,attributeFilter:['hidden']});update();
}
observeDraft(document.getElementById('writing-output'));
observeDraft(document.getElementById('brief-output'));
const chat=document.getElementById('chat');
function formatChat(){chat?.querySelectorAll('.assistant:not([data-formatted])').forEach(el=>{el.dataset.formatted='true';el.replaceChildren(renderDraft(el.textContent));});}
if(chat){formatChat();new MutationObserver(formatChat).observe(chat,{childList:true});}

document.querySelector('[data-nav-search]')?.addEventListener('input',event=>{
 const term=event.target.value.toLowerCase().trim();let count=0;
 document.querySelectorAll('.nav-group').forEach(group=>{let visible=0;group.querySelectorAll('.nav-item').forEach(link=>{link.hidden=!link.textContent.toLowerCase().includes(term);if(!link.hidden){visible++;count++;}});group.hidden=visible===0;});
 document.querySelector('[data-nav-empty]').hidden=count>0;
});
let serviceGroup='All tools';
function filterServices(){const term=document.querySelector('[data-service-search]')?.value.toLowerCase().trim()||'';let count=0;document.querySelectorAll('[data-service-group]').forEach(card=>{card.hidden=(serviceGroup!=='All tools'&&card.dataset.serviceGroup!==serviceGroup)||!card.textContent.toLowerCase().includes(term);if(!card.hidden)count++;});const empty=document.querySelector('[data-service-empty]');if(empty)empty.hidden=count>0;}
document.querySelector('[data-service-search]')?.addEventListener('input',filterServices);
document.querySelectorAll('[data-service-filter]').forEach(button=>button.addEventListener('click',()=>{serviceGroup=button.dataset.serviceFilter;document.querySelectorAll('[data-service-filter]').forEach(other=>{const selected=other===button;other.classList.toggle('selected',selected);other.setAttribute('aria-pressed',String(selected));});filterServices();}));
document.querySelectorAll('[data-select-service]').forEach(button=>button.addEventListener('click',()=>{const select=document.querySelector('form[data-api="save"] select[name="service"]');if(!select)return;select.value=button.dataset.selectService;select.dispatchEvent(new Event('change'));document.querySelectorAll('[data-select-service]').forEach(other=>{other.classList.toggle('selected',other===button);other.setAttribute('aria-pressed',String(other===button));});select.closest('form').scrollIntoView({behavior:'smooth',block:'center'});select.focus({preventScroll:true});}));
function syncWritingCards(){const selected=document.querySelector('#writing-form [name="tool"]')?.value;document.querySelectorAll('[data-writing-tool]').forEach(button=>{const active=button.dataset.writingTool===selected;button.classList.toggle('selected',active);button.setAttribute('aria-pressed',String(active));});}
document.querySelectorAll('[data-writing-tool]').forEach(button=>button.addEventListener('click',()=>{const select=document.querySelector('#writing-form [name="tool"]');select.value=button.dataset.writingTool;select.dispatchEvent(new Event('change'));}));
document.querySelector('#writing-form [name="tool"]')?.addEventListener('change',syncWritingCards);syncWritingCards();
document.querySelector('[data-writing-humanize]')?.addEventListener('click',()=>queueMicrotask(syncWritingCards));

const sidebar=document.getElementById('sidebar'),scrim=document.querySelector('[data-close-sidebar]');
function closeNavigation(){sidebar?.classList.remove('open');document.querySelector('[data-toggle-sidebar]')?.setAttribute('aria-expanded','false');if(scrim)scrim.hidden=true;}
if(sidebar&&scrim)new MutationObserver(()=>scrim.hidden=!sidebar.classList.contains('open')).observe(sidebar,{attributes:true,attributeFilter:['class']});
scrim?.addEventListener('click',closeNavigation);document.addEventListener('keydown',event=>{if(event.key==='Escape')closeNavigation();});
window.matchMedia('(min-width:801px)').addEventListener('change',event=>{if(event.matches)closeNavigation();});
