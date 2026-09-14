<?php
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';SeoExpert::migrate();echo "SEO Expert service tables installed. Existing tools preserved.\n";
