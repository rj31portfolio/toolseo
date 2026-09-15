(() => {
 'use strict';
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
