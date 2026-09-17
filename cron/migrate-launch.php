<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
Launch::migrate();
echo "SEO Zentro blog and business lead storage installed.\n";
