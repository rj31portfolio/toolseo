<?php
// Development server only; mirror Apache's private-directory protections.
$path=parse_url($_SERVER['REQUEST_URI'],PHP_URL_PATH);
if(preg_match('~^/(?:config|includes|database|storage|tests|cron|vendor|uploads)(?:/|$)|(?:^|/)\.|\.(?:sql|log|md|json|lock|example)$~i',$path)){http_response_code(403);echo 'Forbidden';return true;}
if(preg_match('~^/(?:admin|dashboard|auth|api|install|public)/.*\.php$~i',$path)){http_response_code(403);echo 'Forbidden';return true;}
if(str_starts_with($path,'/assets/')&&is_file(dirname(__DIR__).$path))return false;
if($path==='/chat-widget.js')return false;
require dirname(__DIR__).'/index.php';
