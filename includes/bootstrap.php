<?php
declare(strict_types=1);
define('ROOT', dirname(__DIR__));
$config = require ROOT.'/config/config.php';
date_default_timezone_set('UTC');
ini_set('display_errors', '0');
ini_set('log_errors', '1');
ini_set('error_log', ROOT.'/storage/logs/php.log');
spl_autoload_register(function(string $class): void {
 if (preg_match('/^[A-Za-z]+$/', $class) && is_file(ROOT.'/includes/'.$class.'.php')) require ROOT.'/includes/'.$class.'.php';
});
require_once __DIR__.'/functions.php';
require_once __DIR__.'/security.php';
if (PHP_SAPI !== 'cli') {
 if (!is_dir(ROOT.'/storage/sessions')) mkdir(ROOT.'/storage/sessions',0700,true);
 session_save_path(ROOT.'/storage/sessions');
 session_name('seo_session');
 session_set_cookie_params(['lifetime'=>0,'path'=>base_path() ?: '/', 'secure'=>str_starts_with($config['APP_URL'],'https://'),'httponly'=>true,'samesite'=>'Lax']);
 ini_set('session.use_strict_mode','1');
 session_start();
 header('X-Frame-Options: DENY');
 header('X-Content-Type-Options: nosniff');
 header("Content-Security-Policy: default-src 'self'; script-src 'self' https://checkout.razorpay.com; style-src 'self'; img-src 'self' data: https:; connect-src 'self' https://api.razorpay.com; frame-src https://api.razorpay.com; base-uri 'self'; form-action 'self'; frame-ancestors 'none'");
 header('Referrer-Policy: strict-origin-when-cross-origin');
 if(str_starts_with(cfg('APP_URL'),'https://')) header('Strict-Transport-Security: max-age=31536000');
 header('Permissions-Policy: camera=(), microphone=(), geolocation=()');
}
set_exception_handler(function(Throwable $e): void {
 try { if (db()->inTransaction()) db()->rollBack(); } catch(Throwable) {}
 error_log((string)$e);
 if (PHP_SAPI === 'cli') { fwrite(STDERR, "Operation failed: ".$e->getMessage()."\n"); exit(1); }
 $code = $e instanceof HttpError ? $e->getCode() : 500;
 http_response_code($code);
 if($code===419)header('HTTP/1.1 419 Page Expired');
 $message = $code === 500 ? 'The operation could not be completed. Please try again or contact your administrator.' : $e->getMessage();
 if (str_contains($_SERVER['REQUEST_URI'] ?? '', '/api/')) { header('Content-Type: application/json'); echo json_encode(['success'=>false,'message'=>$message]); }
 else { $title = "Error $code"; require ROOT.'/includes/header.php'; echo '<main class="container narrow"><h1>'.e($title).'</h1><p>'.e($message).'</p><a class="button" href="'.url('/').'">Return home</a></main>'; require ROOT.'/includes/footer.php'; }
});
