(() => {
 'use strict';
 const form=document.getElementById('instagram-form');if(!form)return;
 const result=document.getElementById('instagram-result'),status=document.getElementById('instagram-status'),submit=form.querySelector('button');
 const node=(tag,text)=>{const el=document.createElement(tag);if(text!==undefined)el.textContent=text;return el;};
 async function request(url,data,download=false){
  const controller=new AbortController(),timer=setTimeout(()=>controller.abort(),download?100000:45000);
  try{const response=await fetch(url,{method:'POST',body:data,signal:controller.signal});if(!response.ok){const error=await response.json();throw new Error(error.message||'The request could not be completed.');}return download?await response.blob():await response.json();}finally{clearTimeout(timer);}
 }
 const message=error=>error.name==='AbortError'?'The request timed out. Please try again.':error instanceof SyntaxError?'The server returned an unexpected response. Please try again.':error.message;
 form.addEventListener('submit',async event=>{
  event.preventDefault();if(submit.disabled)return;
  try{const url=new URL(form.elements.url.value.trim());if(url.protocol!=='https:'||!['instagram.com','www.instagram.com'].includes(url.hostname)||url.port||url.username||url.password||!/^\/(?:[A-Za-z0-9_][A-Za-z0-9_.]{0,29}\/)?(p|reel)\/[A-Za-z0-9_-]{1,64}\/?$/.test(url.pathname))throw Error();}catch{status.textContent='Paste a valid HTTPS Instagram /p/ or /reel/ URL.';return;}
  submit.disabled=true;submit.textContent='Checking public page…';result.replaceChildren(node('p','Looking for publicly available metadata…'));result.setAttribute('aria-busy','true');status.textContent='Checking Instagram…';
  try{
   const payload=await request(form.action,new FormData(form));if(!payload.success)throw new Error(payload.message);const media=payload.data;result.replaceChildren();
   const label=media.content_kind==='reel'?'Reel':media.type==='video'?'Video post':'Image post';
   result.append(node('h3',media.title));const badge=node('span',label);badge.className='badge';result.append(badge);
   if(media.thumbnail){const image=node('img');image.alt='Public Instagram media preview';image.referrerPolicy='no-referrer';image.addEventListener('error',()=>{image.replaceWith(node('p','The thumbnail could not be loaded. Its link may have expired or Instagram may have blocked it.'));},{once:true});image.src=media.thumbnail;result.append(image);}else result.append(node('p','No thumbnail was exposed in the page metadata.'));
   result.append(node('p',media.notice));
   if(!media.downloadable||!media.token){status.textContent='Video unavailable. Instagram provided only a preview; no thumbnail download will be offered.';return;}
   const downloadLabel=media.content_kind==='reel'?'Download reel':media.type==='video'?'Download video':'Download post image';
   const button=node('button',downloadLabel);button.type='button';button.className='button';result.append(button);
   button.addEventListener('click',async()=>{
    button.disabled=true;submit.disabled=true;button.textContent='Downloading…';status.textContent='Fetching the available media…';
    try{const data=new FormData();data.set('csrf',form.elements.csrf.value);data.set('token',media.token);const blob=await request(form.dataset.downloadUrl,data,true);const ext={'video/mp4':'mp4','video/webm':'webm','image/jpeg':'jpg','image/png':'png','image/webp':'webp','image/gif':'gif'}[blob.type];if(!ext||!blob.type.startsWith(media.type+'/'))throw new Error('The server did not return the expected '+media.type+' file.');const href=URL.createObjectURL(blob),link=node('a');link.href=href;link.download=`instagram-${media.content_kind==='reel'?'reel':media.type}.${ext}`;document.body.append(link);link.click();link.remove();setTimeout(()=>URL.revokeObjectURL(href),60000);status.textContent='Download ready. Check your browser downloads.';}catch(error){status.textContent=message(error);}finally{button.disabled=false;submit.disabled=false;button.textContent=downloadLabel;}
   });status.textContent='Available public metadata found.';
  }catch(error){result.replaceChildren(node('p','No media is available to download.'));status.textContent=message(error);}
  finally{submit.disabled=false;submit.textContent='Find available media';result.setAttribute('aria-busy','false');}
 });
})();
