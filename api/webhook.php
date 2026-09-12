<?php
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Method not allowed.',405);
$raw=file_get_contents('php://input',false,null,0,1048577);if(strlen($raw)>1048576)fail('Payload too large.',413);
Payment::webhook($raw,$_SERVER['HTTP_X_RAZORPAY_SIGNATURE']??'');json_response([],'Webhook received');
