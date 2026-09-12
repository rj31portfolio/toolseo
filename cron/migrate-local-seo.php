<?php
if(PHP_SAPI!=='cli'){http_response_code(403);exit;}
require dirname(__DIR__).'/includes/bootstrap.php';
db()->exec(file_get_contents(ROOT.'/database/migrations/006-local-seo.sql'));
query("INSERT INTO settings(name,value) VALUES ('migration_006','true') ON DUPLICATE KEY UPDATE value='true'");
echo "Local SEO audit storage is ready. Existing records were preserved.\n";
