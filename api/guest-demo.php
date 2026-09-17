<?php
header('Cache-Control: no-store');
if($_SERVER['REQUEST_METHOD']!=='POST')fail('Use POST.',405);
check_csrf();
$tool=enum_input('tool',GuestDemo::TOOLS);$operation=enum_input('operation',['status','use']);
json_response(GuestDemo::quota($tool,$operation==='use'),'Demo access updated.');
