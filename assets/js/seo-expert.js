(() => {
 'use strict';
 const duration = document.querySelector('[data-expert-duration]'), dialog = document.querySelector('#expert-enquiry'), form = document.querySelector('[data-expert-enquiry]');
 const updatePrices = () => document.querySelectorAll('[data-expert-pricing]').forEach(group => { group.hidden = group.dataset.expertPricing !== duration.value; });
 if (duration) { duration.addEventListener('change',updatePrices); updatePrices(); }
 const open = (type,plan,months) => {
  if (!dialog || !form) return;
  form.elements.request_type.value = ['audit','hire','plan'].includes(type)?type:'hire';
  form.elements.plan.value = ['starter','growth','pro'].includes(plan)?plan:'undecided';
  form.elements.duration.value = ['3','6','12'].includes(months)?months:(duration?.value || '3');
  document.querySelector('#expert-enquiry-title').textContent = type === 'audit'?'Request your free SEO audit':'Tell us about your business';
  if (!dialog.open) dialog.showModal();
 };
 document.querySelectorAll('[data-expert-open]').forEach(button => button.addEventListener('click',event => {event.preventDefault();open(button.dataset.expertOpen,button.dataset.plan,button.dataset.duration);}));
 document.querySelector('[data-expert-close]')?.addEventListener('click',()=>dialog.close());
 const params = new URLSearchParams(location.search);
 if (params.get('enquire') === '1') open(params.get('type') || (params.get('plan')?'plan':'hire'),params.get('plan'),params.get('duration'));
 form?.addEventListener('submit', async event => {
  event.preventDefault();const button = form.querySelector('button[type=submit],button.button'), feedback = form.querySelector('[data-expert-feedback]');
  if (button.disabled) return;button.disabled = true;feedback.textContent = 'Sending your enquiry…';
  try {
   const response = await fetch(form.action,{method:'POST',body:new FormData(form),headers:{Accept:'application/json'},credentials:'same-origin'});
   const result = await response.json();if (!response.ok || !result.success) throw new Error(result.message || 'Could not send your enquiry.');
   feedback.textContent = result.message + ' Reference: ' + result.data.reference;button.textContent = 'Enquiry received';
  } catch(error) {feedback.textContent = error.message || 'Please try again.';button.disabled = false;}
 });
})();
