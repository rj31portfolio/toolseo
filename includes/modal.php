<?php
function render_modal(string $id,string $title,string $body): void {echo '<dialog id="'.e($id).'" class="card"><form method="dialog"><button class="text-button" aria-label="Close dialog">✕</button></form><h2>'.e($title).'</h2><p>'.e($body).'</p></dialog>';}
