<?php
if(PHP_SAPI!=='cli')exit;
require dirname(__DIR__).'/includes/bootstrap.php';
LiveChat::migrate();echo "Live chat tables installed. Existing users, subscriptions and notifications preserved.\n";
