<?php
function pagination(int $page,int $total,int $perPage,string $path): void {$pages=max(1,(int)ceil($total/$perPage));echo '<nav class="pagination" aria-label="Pagination">';if($page>1)echo '<a href="'.e($path.'&page='.($page-1)).'">← Previous</a>';echo '<span>Page '.$page.' of '.$pages.'</span>';if($page<$pages)echo '<a href="'.e($path.'&page='.($page+1)).'">Next →</a>';echo '</nav>';}
