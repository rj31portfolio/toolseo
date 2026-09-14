(() => {
 'use strict';
 const script=document.currentScript;if(!script)return;
 const base=new URL('./',script.src),widget=script.dataset.widget,demo=script.hasAttribute('data-demo');
 if(!demo&&!/^[a-f0-9]{32}$/.test(widget||''))return;
 const target=script.dataset.target?document.getElementById(script.dataset.target):document.body;if(!target)return;
 const host=document.createElement('div');host.setAttribute('data-chat-widget',widget||'demo');target.append(host);
 const shadow=host.attachShadow({mode:'open'}),css=document.createElement('link');css.rel='stylesheet';css.href=new URL('assets/css/chat-widget.css',base).href;shadow.append(css);
 const el=(tag,text,cls)=>{const n=document.createElement(tag);if(text!==undefined)n.textContent=text;if(cls)n.className=cls;return n;};
 let token='',opened=false,busy=false,polling=false,leadCaptured=false,mode='bot',messages=[],timer=null,configuration;
 const storageKey='seo-chat:'+base.origin+base.pathname+':'+widget;
 if(!demo)try{token=sessionStorage.getItem(storageKey)||'';}catch{}
 const demoConfig={name:'Bloom Studio',business_info:'We help growing businesses with website design, SEO and content. Tell us what you are planning and we will help you find the right service.',config:{color:'#18634f',position:'right',size:'standard',button_style:'pill',avatar:'B',welcome:'Hello! Welcome to Bloom Studio.',placeholder:'Ask about our services…',offline:'Our team is away. Leave your details.',online:true,mobile:true,desktop:true,branding:true,fields:{name:'required',phone:'required',email:'required',service:'required',message:'optional'}}};
 async function request(action,data={}){
  if(demo){await new Promise(resolve=>setTimeout(resolve,400));if(action==='start')messages=[{id:1,role:'assistant',body:demoConfig.config.welcome+'\n\n'+demoConfig.business_info}];if(action==='message'){messages.push({id:messages.length+1,role:'visitor',body:data.message},{id:messages.length+2,role:'assistant',body:/price|cost|quote/i.test(data.message)?'Our team prepares a quote around your goals and scope. Share your preferred service and contact details to request one.':/seo/i.test(data.message)?'Our SEO service includes a website review, keyword planning and on-page improvements. Would you like the team to contact you?':'We offer website design, SEO and content services. Tell us which service interests you, or request a follow-up below.'});}if(action==='lead'){leadCaptured=true;messages.push({id:messages.length+1,role:'assistant',body:'Demo complete! In your own widget, this request would appear in your Leads dashboard. No details were saved or sent.'});}return {token:'demo',messages,lead_captured:leadCaptured,mode:'bot'};}
  const controller=new AbortController(),timeout=setTimeout(()=>controller.abort(),15000);
  try{const response=await fetch(new URL('api/chat/'+action+'?widget='+widget,base),{method:action==='config'?'GET':'POST',credentials:'omit',headers:action==='config'?{}:{'Content-Type':'application/json'},body:action==='config'?undefined:JSON.stringify({...data,token}),signal:controller.signal});let payload;try{payload=await response.json();}catch{throw Error('Chat is temporarily unavailable. Please try again.');}if(!response.ok||!payload.success){if(response.status===401){token='';try{sessionStorage.removeItem(storageKey);}catch{}}throw Error(payload.message||'Unable to connect.');}return payload.data;}finally{clearTimeout(timeout);}
 }
 function boot(data){
  configuration=data;const c=data.config;
  host.classList.add(c.position,c.size,c.button_style);if(demo)host.classList.add('inline');if(!c.mobile)host.classList.add('hide-mobile');if(!c.desktop)host.classList.add('hide-desktop');host.style.setProperty('--chat-primary',c.color);
  const rgb=c.color.slice(1).match(/../g).map(hex=>{const channel=parseInt(hex,16)/255;return channel<=.04045?channel/12.92:((channel+.055)/1.055)**2.4;});
  host.style.setProperty('--chat-on-primary',rgb[0]*.2126+rgb[1]*.7152+rgb[2]*.0722>.179?'#102a22':'#ffffff');
  const launcher=el('button',c.button_style==='circle'?'✦':'Let’s chat','launcher');launcher.type='button';launcher.setAttribute('aria-label','Open '+data.name+' chat');launcher.setAttribute('aria-expanded','false');
  const panel=el('section',undefined,'panel');panel.hidden=true;panel.setAttribute('aria-label',data.name+' chat');
  const heading=el('header',undefined,'heading'),avatar=el('span',c.avatar||'Chat','avatar');
  if(c.logo){const image=el('img');image.src=c.logo;image.alt='';image.referrerPolicy='no-referrer';image.addEventListener('error',()=>image.remove());avatar.replaceChildren(image);}
  const title=el('div');title.append(el('strong',data.name),el('small',demo?'Interactive demo · nothing is saved':c.online?'Business assistant · ask us a question':'Leave a message · team offline'));
  const close=el('button','×','close');close.type='button';close.setAttribute('aria-label','Close chat');heading.append(avatar,title,close);
  const log=el('div',undefined,'messages');log.setAttribute('role','log');log.setAttribute('aria-live','polite');log.setAttribute('aria-relevant','additions');
  const status=el('p','','status');status.setAttribute('role','status');const tools=el('div',undefined,'actions');
  const contact=el('button','Request a follow-up','contact');contact.type='button';const restart=el('button','New chat','text-button');restart.type='button';tools.append(contact,restart);
  const form=el('form',undefined,'composer'),input=el('input');input.placeholder=c.placeholder;input.maxLength=2000;input.required=true;input.setAttribute('aria-label','Message');const send=el('button','Send');send.type='submit';form.append(input,send);
  const leadForm=el('form',undefined,'lead-form');leadForm.hidden=true;leadForm.append(el('h3',demo?'Try lead capture':'Let’s stay in touch'),el('p',demo?'Use example details. This demo does not save or send them.':'Share your details so this business can follow up about your request.'));
  for(const [key,label] of Object.entries({name:'Name',phone:'Phone number',email:'Email',service:'Interested service / product',message:'Message (optional)'})){
   if(c.fields[key]==='hidden')continue;const labelEl=el('label',label),field=el(key==='message'?'textarea':'input');field.name=key;if(key!=='message')field.type=key==='email'?'email':key==='phone'?'tel':'text';field.maxLength={name:120,phone:40,email:190,service:190,message:2000}[key];field.required=c.fields[key]==='required';if(field.required)labelEl.append(document.createTextNode(' *'));labelEl.append(field);leadForm.append(labelEl);
  }
  const consentLabel=el('label',undefined,'consent'),consent=el('input');consent.type='checkbox';consent.name='consent';consent.required=true;consentLabel.append(consent,document.createTextNode(demo?'I understand this is a demo.':'I agree to be contacted by '+data.name+' about this request.'));leadForm.append(consentLabel);
  const submit=el('button',demo?'Try submitting':'Send my details');submit.type='submit';const back=el('button','Back to chat','text-button');back.type='button';leadForm.append(submit,back);
  panel.append(heading,log,leadForm,status,tools,form);if(c.branding)panel.append(el('div','Powered by SEO AutoPilot','branding'));shadow.append(panel,launcher);
  function showLead(show){leadForm.hidden=!show;log.hidden=show;form.hidden=show;tools.hidden=show;if(show)leadForm.querySelector('input')?.focus();}
  function render(result){
   if(result.token){token=result.token;if(!demo)try{sessionStorage.setItem(storageKey,token);}catch{}}
   messages=result.partial?[...messages,...(result.messages||[]).filter(next=>!messages.some(old=>old.id===next.id))]:(result.messages||[]);mode=result.mode||'bot';leadCaptured=!!result.lead_captured;
   for(const message of messages){if(log.querySelector('[data-id="'+Number(message.id)+'"]'))continue;const bubble=el('div',undefined,'bubble '+message.role);bubble.dataset.id=message.id;bubble.append(el('small',message.role==='visitor'?'You':message.role==='agent'?'Team':message.role==='system'?'Update':'Assistant'),el('div',message.body));log.append(bubble);log.scrollTop=log.scrollHeight;}
   contact.hidden=leadCaptured;send.disabled=mode==='closed';input.disabled=mode==='closed';if(mode==='closed')status.textContent='Conversation closed. Select New chat to continue.';else if(mode==='human')status.textContent='Your conversation is with the team. Replies appear here.';
   if(!leadCaptured&&messages.filter(m=>m.role==='visitor').length>=2)contact.textContent='Ready for the next step? Leave your details';
  }
  async function poll(){if(!host.isConnected){clearInterval(timer);return;}if(!opened||busy||polling||demo||!token||document.hidden)return;polling=true;try{render(await request('poll',{after:Number(messages.at(-1)?.id||0)}));}catch(error){status.textContent=error.message;}finally{polling=false;}}
  async function open(){opened=true;panel.hidden=false;launcher.hidden=true;launcher.setAttribute('aria-expanded','true');if(!demo)input.focus();if(!token){busy=true;status.textContent='Connecting…';try{render(await request('start'));status.textContent='';}catch(error){status.textContent=error.name==='AbortError'?'Connection timed out. Try opening chat again.':error.message;}finally{busy=false;}}else await poll();clearInterval(timer);if(!demo)timer=setInterval(poll,5000);}
  function hide(){opened=false;panel.hidden=true;launcher.hidden=false;launcher.setAttribute('aria-expanded','false');clearInterval(timer);launcher.focus();}
  launcher.addEventListener('click',open);close.addEventListener('click',()=>{if(!leadCaptured&&messages.some(m=>m.role==='visitor')&&leadForm.hidden){showLead(true);status.textContent='Would you like a follow-up before leaving? You can close chat without submitting.';}else hide();});
  panel.addEventListener('keydown',event=>{if(event.key==='Escape')hide();});contact.addEventListener('click',()=>showLead(true));back.addEventListener('click',()=>{showLead(false);input.focus();});
  restart.addEventListener('click',()=>{if(busy)return;token='';leadCaptured=false;messages=[];log.replaceChildren();showLead(false);if(!demo)try{sessionStorage.removeItem(storageKey);}catch{}open();});
  form.addEventListener('submit',async event=>{event.preventDefault();if(busy||!input.value.trim()||!token)return;busy=true;send.disabled=true;const message=input.value.trim();status.textContent='Sending…';try{render(await request('message',{message,client_id:globalThis.crypto?.randomUUID?.()||Date.now()+'-'+Math.random().toString(36).slice(2)}));input.value='';status.textContent=mode==='human'?'Your message has been sent to the team.':'';}catch(error){status.textContent=error.name==='AbortError'?'Message timed out. Please check the conversation before retrying.':error.message;}finally{busy=false;send.disabled=mode==='closed';input.focus();}});
  leadForm.addEventListener('submit',async event=>{event.preventDefault();if(busy||!token)return;busy=true;submit.disabled=true;status.textContent='Submitting…';const fields=Object.fromEntries(new FormData(leadForm));fields.consent=consent.checked;try{render(await request('lead',fields));showLead(false);leadForm.reset();status.textContent=demo?'Demo complete. Nothing was saved.':'Your request was saved. Thank you.';}catch(error){status.textContent=error.name==='AbortError'?'Submission timed out. Try again; duplicate leads are prevented.':error.message;}finally{busy=false;submit.disabled=false;}});
  if(demo)open();
 }
 (demo?Promise.resolve(demoConfig):request('config')).then(boot).catch(()=>host.remove());
})();
