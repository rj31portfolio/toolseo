<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
$marker=setting('migration_002',false);if(!$marker){foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents(ROOT.'/database/migrations/002-workflows.sql')) as $sql)if(trim($sql)!==''){try{db()->exec($sql);}catch(PDOException $e){if(!in_array($e->errorInfo[1]??0,[1060,1050,1062],true))throw $e;}}query("INSERT INTO settings(name,value) VALUES ('migration_002','true') ON DUPLICATE KEY UPDATE value='true'");echo "Migration 002 applied.\n";}else echo "Database is current.\n";
if(!setting('migration_003',false)){db()->exec(file_get_contents(ROOT.'/database/migrations/003-recommendations.sql'));query("INSERT INTO settings(name,value) VALUES ('migration_003','true')");echo "Migration 003 applied.\n";}
if(!setting('migration_004',false)){foreach(preg_split('/;\s*(?:\r?\n|$)/',file_get_contents(ROOT.'/database/migrations/004-services.sql')) as $sql)if(trim($sql)!=='')db()->exec($sql);query("INSERT INTO settings(name,value) VALUES ('migration_004','true')");echo "Migration 004 applied.\n";}
if(!setting('migration_005',false)){db()->exec(file_get_contents(ROOT.'/database/migrations/005-credit-recovery.sql'));query("INSERT INTO settings(name,value) VALUES ('migration_005','true')");echo "Migration 005 applied.\n";}

BtoBLeads::migrate();echo "B2B Lead Extractor migration applied.\n";
