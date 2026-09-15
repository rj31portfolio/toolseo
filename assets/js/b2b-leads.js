(() => {
 'use strict';
 document.querySelector('[data-lead-discover]')?.addEventListener('submit', async event => {
  event.preventDefault();
  const form = event.target, button = form.querySelector('button');
  if (button.disabled) return;
  const output = document.querySelector('[data-lead-discovery-results]');
  button.disabled = true; output.textContent = 'Searching listings. This may take up to 90 seconds…';
  try {
   const response = await api('b2b-leads', new FormData(form));
   output.replaceChildren();
   const status = document.createElement('p'); status.textContent = response.message; output.append(status);
   for (const result of response.data.results) {
    const card = document.createElement('div'); card.className = 'card stack';
    const link = document.createElement('a'); link.href = result.url; link.target = '_blank'; link.rel = 'noopener noreferrer'; link.textContent = result.title;
    const snippet = document.createElement('p'); snippet.textContent = result.snippet;
    const review = document.createElement('button'); review.type = 'button'; review.className = 'button secondary'; review.textContent = 'Review and add lead';
    review.addEventListener('click', () => {
     const editor = document.querySelector('#lead-editor form');
     editor.reset(); editor.elements.id.value = '0';
     for (const name of ['business_name','category','city','state','website','email','phone','provenance']) editor.elements[name].value = '';
     editor.elements.source_id.value = result.source_id;
     editor.elements.provenance.value = 'Discovered via Google / HasData: ' + result.url;
     editor.elements.authorized.checked = false;
     document.querySelector('#lead-editor h2').textContent = 'Review and add lead';
     editor.querySelector('[name=business_name]').focus();
     document.querySelector('#lead-editor').scrollIntoView({behavior:'smooth'});
    });
    card.append(link, snippet, review); output.append(card);
   }
  } catch (error) { output.textContent = error.message || 'Lead discovery failed. Please retry.'; }
  finally { button.disabled = false; }
 });
 document.querySelector('[data-lead-select-all]')?.addEventListener('change', event => {
  document.querySelectorAll('#lead-bulk input[name="ids[]"]').forEach(input => { input.checked = event.target.checked; });
 });
 document.querySelector('[data-lead-export]')?.addEventListener('submit', event => {
  const form = event.target;
  form.querySelectorAll('input[name="ids[]"]').forEach(input => input.remove());
  if (!form.querySelector('[data-export-selected]').checked) return;
  const checked = document.querySelectorAll('#lead-bulk input[name="ids[]"]:checked');
  if (!checked.length) { event.preventDefault(); alert('Select leads to export first.'); return; }
  checked.forEach(input => { const field = document.createElement('input'); field.type = 'hidden'; field.name = 'ids[]'; field.value = input.value; form.append(field); });
 });
 document.querySelector('[data-lead-demo]')?.addEventListener('submit', async event => {
  event.preventDefault(); const form = event.target; const button = form.querySelector('button');
  const output = document.querySelector('[data-lead-demo-results]');
  button.disabled = true; output.textContent = 'Searching approved leads…';
  try {
   const response = await fetch(form.action, { method: 'POST', body: new FormData(form), credentials: 'same-origin' });
   const result = await response.json(); if (!response.ok || !result.success) throw new Error(result.message || 'Search could not complete.');
   output.replaceChildren(); const note = document.createElement('p'); note.textContent = result.message; output.append(note);
   const leads = result.data.leads.slice(0, 5);
   if (!leads.length) { const empty = document.createElement('p'); empty.textContent = 'No matching approved demo leads. An administrator can import authorized lists and approve up to five public previews.'; output.append(empty); return; }
   const wrap = document.createElement('div'); wrap.className = 'table-wrap lead-demo-results'; const table = document.createElement('table');
   const head = table.createTHead().insertRow(); ['Business Name','Category','Location','Website','Public Phone','Public Email','Source','Lead Score'].forEach(label => { const th = document.createElement('th'); th.textContent = label; head.append(th); });
   const body = table.createTBody(); leads.forEach(lead => { const tr = body.insertRow(); [lead.business_name,lead.category,[lead.city,lead.state].filter(Boolean).join(', '),lead.website,lead.phone,lead.email,lead.source,`${lead.rating} · ${lead.score}`].forEach(value => { tr.insertCell().textContent = value || 'Not available'; }); });
   wrap.append(table); output.append(wrap);
  } catch (error) { output.textContent = error.message || 'Search unavailable. Please try again.'; }
  finally { button.disabled = false; }
 });
})();
