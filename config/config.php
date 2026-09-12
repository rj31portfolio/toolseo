<?php
$config = require __DIR__.'/config.example.php';
$private = getenv('SEO_CONFIG_FILE') ?: __DIR__.'/local.php';
if (is_file($private)) $config = array_replace($config, require $private);
foreach ($config as $key => $value) if (getenv($key) !== false) $config[$key] = getenv($key);
return $config;