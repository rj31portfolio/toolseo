<?php
// XAMPP smoke test: use a temporary account and remove it when finished.
if (PHP_SAPI !== 'cli') exit;
require dirname(__DIR__).'/includes/bootstrap.php';
$client = curl_init();
curl_setopt_array($client, [CURLOPT_RETURNTRANSFER=>true, CURLOPT_FOLLOWLOCATION=>true, CURLOPT_COOKIEFILE=>'', CURLOPT_TIMEOUT=>15, CURLOPT_PROXY=>'']);
$checks = 0;
function request_page(string $path, ?array $post = null, int $expected = 200): string {
 global $client, $checks;
 curl_setopt($client, CURLOPT_URL, rtrim(cfg('APP_URL'), '/').$path);
 if ($post !== null) curl_setopt($client, CURLOPT_POSTFIELDS, http_build_query($post));
 else curl_setopt($client, CURLOPT_HTTPGET, true);
 $body = curl_exec($client);
 if ($body === false) throw new RuntimeException(curl_error($client));
 $status = curl_getinfo($client, CURLINFO_RESPONSE_CODE);
 if ($status !== $expected) throw new RuntimeException("$path expected $expected, got $status");
 echo "PASS $path ($status)\n";
 $checks++;
 return $body;
}
$uid = null;
try {
 $home = request_page('/');
 request_page('/index.php');
 foreach (['features','pricing','how-it-works','seo-tools','about','contact','blog','terms','privacy','refund-policy','cookie-policy','login','register','forgot-password','sitemap.xml'] as $path) request_page('/'.$path);
 preg_match_all('~(?:href|src)="(/[^"<>]*)"~', $home, $links);
 foreach (array_unique($links[1]) as $link) {
  if (!str_starts_with($link, base_path().'/')) throw new RuntimeException('Link missing base path: '.$link);
  if (str_contains($link, '/assets/')) request_page(substr(html_entity_decode($link), strlen(base_path())));
 }
 request_page('/does-not-exist', null, 404);
 request_page('/config/local.php', null, 403);
 $email = 'routing-'.bin2hex(random_bytes(8)).'@example.test';
 $password = bin2hex(random_bytes(24));
 query("INSERT INTO users(name,email,password,role,verified_at) VALUES (?,?,?,'super_admin',NOW())", ['Routing smoke test', $email, password_hash($password, PASSWORD_DEFAULT)]);
 $uid = (int)db()->lastInsertId();
 query("INSERT INTO user_roles(user_id,role_id) SELECT ?,id FROM roles WHERE name='super_admin'", [$uid]);
 $login = request_page('/login');
 preg_match('/name="csrf" value="([a-f0-9]+)"/', $login, $match);
 if (empty($match[1])) throw new RuntimeException('Login CSRF token missing');
 $dashboard = request_page('/login', ['csrf'=>$match[1], 'email'=>$email, 'password'=>$password]);
 if (!str_contains(curl_getinfo($client, CURLINFO_EFFECTIVE_URL), '/dashboard')) throw new RuntimeException('Login did not reach dashboard');
 foreach (['dashboard','websites','profile','billing','notifications','keywords','audit','reports','admin','admin/users','admin/plans','admin/settings','admin/logs'] as $path) request_page('/'.$path);
 preg_match('/name="csrf-token" content="([a-f0-9]+)"/', $dashboard, $match);
 if (empty($match[1])) throw new RuntimeException('Dashboard CSRF token missing');
 $csrf = $match[1];
 query('INSERT INTO websites(user_id,name,domain,domain_hash) VALUES (?,?,?,?)', [$uid,'Audit batch fixture','https://example.test/',hash('sha256',$email)]);
 $wid = (int)db()->lastInsertId();
 $started = json_decode(request_page('/api/v1/crawl', ['csrf'=>$csrf,'website_id'=>$wid]), true);
 $jobId = (int)$started['data']['job_id'];
 $again = json_decode(request_page('/api/v1/crawl', ['csrf'=>$csrf,'website_id'=>$wid]), true);
 if ((int)$again['data']['job_id'] !== $jobId) throw new RuntimeException('Repeated start created a duplicate job');
 // A robots-blocked fixture exercises batching without external requests.
 query('UPDATE crawl_jobs SET robots=? WHERE id=?', ["User-agent: *\nDisallow: /",$jobId]);
 query('INSERT INTO crawl_urls(job_id,url,url_hash) VALUES (?,?,?)', [$jobId,'https://example.test/two',hash('sha256','https://example.test/two')]);
 $auditPage = request_page('/audit?website_id='.$wid);
 if (!str_contains($auditPage,'data-crawl-can-run="1"')) throw new RuntimeException('Audit page does not enable batch processing');
 request_page('/api/v1/crawl-step', ['website_id'=>$wid], 419);
 $step = json_decode(request_page('/api/v1/crawl-step', ['csrf'=>$csrf,'website_id'=>$wid]), true);
 if ($step['data']['status'] !== 'running' || (int)value("SELECT COUNT(*) FROM crawl_urls WHERE job_id=? AND status='blocked'",[$jobId]) !== 1) throw new RuntimeException('Batch did not process exactly one URL');
 $step = json_decode(request_page('/api/v1/crawl-step', ['csrf'=>$csrf,'website_id'=>$wid]), true);
 if ($step['data']['status'] !== 'failed' || !$step['data']['error']) throw new RuntimeException('Blocked crawl did not return a terminal error');
 // Terminal jobs must stay terminal when progress is requested again.
 $step = json_decode(request_page('/api/v1/crawl-step', ['csrf'=>$csrf,'website_id'=>$wid]), true);
 if ($step['data']['status'] !== 'failed') throw new RuntimeException('Terminal job restarted unexpectedly');
 echo "PASS duplicate start, batch size, CSRF rejection and terminal errors\n";
 request_page('/logout', ['csrf'=>$match[1]]);
 request_page('/dashboard');
 if (!str_ends_with(curl_getinfo($client, CURLINFO_EFFECTIVE_URL), '/login')) throw new RuntimeException('Logged-out dashboard did not redirect to login');
 echo "PASS: $checks routing and authentication checks\n";
} finally {
 curl_close($client);
 if ($uid !== null) {
  query('DELETE FROM websites WHERE user_id=?', [$uid]);
  query('DELETE FROM audit_logs WHERE user_id=?', [$uid]);
  query('DELETE FROM auth_tokens WHERE user_id=?', [$uid]);
  query('DELETE FROM user_roles WHERE user_id=?', [$uid]);
  query('DELETE FROM users WHERE id=?', [$uid]);
 }
}
