<?php
class HttpError extends RuntimeException {}
function fail(string $message,int $code=422): never { throw new HttpError($message,$code); }
function csrf(): string { return $_SESSION['csrf'] ??= bin2hex(random_bytes(32)); }
function check_csrf(): void { if (!hash_equals(csrf(),(string)($_POST['csrf'] ?? $_SERVER['HTTP_X_CSRF_TOKEN'] ?? ''))) fail('Your session token is invalid. Refresh and try again.',419); }
function input(string $key,int $max=255,string $default=''): string { $v=$_POST[$key]??$default; if (!is_string($v) || mb_strlen($v)>$max) fail('Invalid '.$key); return trim($v); }
function required_input(string $key,int $max=255): string { $v=input($key,$max); if ($v==='') fail(ucfirst($key).' is required.'); return $v; }
function enum_input(string $key,array $values,string $default=''): string { $v=input($key,100,$default); if (!in_array($v,$values,true)) fail('Invalid '.$key); return $v; }
function rate_limit(string $scope,int $limit=10,int $seconds=900,?string $identity=null): void {
 $key=hash('sha256',$scope.'|'.($identity??($_SERVER['REMOTE_ADDR'] ?? 'cli')));
 query('INSERT INTO rate_limits (bucket,hits,expires_at) VALUES (?,1,DATE_ADD(NOW(),INTERVAL ? SECOND)) ON DUPLICATE KEY UPDATE hits=IF(expires_at<NOW(),1,hits+1), expires_at=IF(expires_at<NOW(),VALUES(expires_at),expires_at)',[$key,$seconds]);
 if ((int)value('SELECT hits FROM rate_limits WHERE bucket=?',[$key])>$limit) fail('Too many requests. Please try again later.',429);
}
function current_user(): ?array { static $loaded=false,$user=null; if (!$loaded) { $loaded=true; if (isset($_SESSION['user_id'])) { $user=row('SELECT * FROM users WHERE id=? AND active=1',[$_SESSION['user_id']]); if($user && ($_SESSION['session_version']??0)!== (int)$user['session_version']){$user=null;unset($_SESSION['user_id']);} } } return $user; }
function require_user(): array { $u=current_user(); if (!$u) { if (str_contains($_SERVER['REQUEST_URI']??'','/api/')) fail('Please sign in.',401); redirect('/login'); } if (isset($_SESSION['last_seen']) && time()-$_SESSION['last_seen']>7200) { session_destroy(); fail('Your session has expired. Sign in again.',401); } $_SESSION['last_seen']=time(); return $u; }
function is_admin(?array $u=null): bool { $u ??=current_user(); return in_array($u['role']??'',['super_admin','admin'],true); }
function require_admin(bool $super=false): array { $u=require_user(); if (!is_admin($u)||($super && $u['role']!=='super_admin')) fail('You do not have permission to access this page.',403); return $u; }
function website(int $id): array { $u=require_user(); $w=row('SELECT * FROM websites WHERE id=?',[$id]); if (!$w) fail('Website not found.',404); if (!is_admin($u) && $w['user_id']!=$u['id'] && !value('SELECT id FROM team_members WHERE user_id=? AND website_id=?',[$u['id'],$id])) fail('This project is not assigned to you.',403); return $w; }
function owned_website(int $id): array { $w=website($id); if (!is_admin() && $w['user_id']!=require_user()['id']) fail('Only the project owner can perform this action.',403); return $w; }
function websites(): array { $u=require_user(); return is_admin($u)?rows('SELECT * FROM websites ORDER BY id DESC LIMIT 500'):rows('SELECT DISTINCT w.* FROM websites w LEFT JOIN team_members t ON t.website_id=w.id WHERE w.user_id=? OR t.user_id=? ORDER BY w.id DESC LIMIT 500',[$u['id'],$u['id']]); }
function plan(int $uid): array { $grace=max(0,min(14,(int)setting('grace_days',0))); return row("SELECT p.* FROM subscriptions s JOIN plans p ON p.id=s.plan_id WHERE s.user_id=? AND s.status='active' AND (s.ends_at IS NULL OR DATE_ADD(s.ends_at,INTERVAL ? DAY)>NOW()) ORDER BY s.id DESC LIMIT 1",[$uid,$grace]) ?? row("SELECT * FROM plans WHERE slug='free'"); }
function limit_check(int $uid,string $feature,int $used): void { $p=plan($uid); $limit=(int)($p[$feature]??0); if ($limit>=0 && $used >= $limit) fail('Your '.$p['name'].' plan limit has been reached. Upgrade your plan to continue.'); }
