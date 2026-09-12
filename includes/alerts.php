<?php if (isset($_SESSION['flash'])) { echo '<div class="alert" role="status">'.e($_SESSION['flash']).'</div>'; unset($_SESSION['flash']); } ?>
<div id="toast" class="toast" role="status" hidden></div>
