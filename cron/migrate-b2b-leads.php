<?php
if (PHP_SAPI !== 'cli') { http_response_code(403); exit; }
require dirname(__DIR__).'/includes/bootstrap.php';
BtoBLeads::migrate();
echo "B2B Lead Extractor tables installed. No sample leads inserted.\n";
