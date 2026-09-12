<?php
function cfg(string $key): mixed { global $config; return $config[$key] ?? null; }
function base_path(): string { return rtrim(parse_url(cfg('APP_URL'), PHP_URL_PATH) ?: '', '/'); }
function url(string $path = '/'): string { return base_path().'/'.ltrim($path,'/'); }
function e(mixed $value): string { return htmlspecialchars((string)($value ?? ''), ENT_QUOTES | ENT_SUBSTITUTE,'UTF-8'); }
function db(): PDO {
 static $pdo;
 if (!$pdo) $pdo = new PDO('mysql:host='.cfg('DB_HOST').';port='.cfg('DB_PORT').';dbname='.cfg('DB_NAME').';charset=utf8mb4',cfg('DB_USER'),cfg('DB_PASS'),[PDO::ATTR_ERRMODE=>PDO::ERRMODE_EXCEPTION,PDO::ATTR_DEFAULT_FETCH_MODE=>PDO::FETCH_ASSOC,PDO::ATTR_EMULATE_PREPARES=>false]);
 return $pdo;
}
function query(string $sql, array $params = []): PDOStatement { $s=db()->prepare($sql); $s->execute($params); return $s; }
function rows(string $sql,array $params=[]): array { return query($sql,$params)->fetchAll(); }
function row(string $sql,array $params=[]): ?array { return query($sql,$params)->fetch() ?: null; }
function value(string $sql,array $params=[]): mixed { return query($sql,$params)->fetchColumn(); }
function redirect(string $path): never { header('Location: '.url($path),true,303); exit; }
function json_response(mixed $data=[],string $message='Saved'): never { header('Content-Type: application/json'); echo json_encode(['success'=>true,'message'=>$message,'data'=>$data],JSON_THROW_ON_ERROR); exit; }
function setting(string $key,mixed $fallback=null): mixed { try { $v=value('SELECT value FROM settings WHERE name=?',[$key]); return $v === false ? $fallback : json_decode($v,true); } catch(Throwable) { return $fallback; } }
function audit_log(string $action, array $context=[]): void { query('INSERT INTO audit_logs (user_id,action,context,ip) VALUES (?,?,?,?)',[$_SESSION['user_id'] ?? null,$action,json_encode($context),$_SERVER['REMOTE_ADDR'] ?? 'cli']); }
function notify(int $uid,string $message,string $path='/dashboard'): void { query('INSERT INTO notifications (user_id,message,path) VALUES (?,?,?)',[$uid,$message,$path]); }
function field(string $name,string $label,string $type='text',mixed $val='',bool $required=true): void { echo '<label>'.e($label).'<input name="'.e($name).'" type="'.e($type).'" value="'.e($val).'" '.($required?'required':'').' '.($type==='password'?'autocomplete="new-password" '.(in_array($name,['password','admin_password','new_password'])?'minlength="12"':''):'').'></label>'; }
function select_field(string $name,string $label,array $options,mixed $selected=''): void { echo '<label>'.e($label).'<select name="'.e($name).'">'; foreach($options as $k=>$v) echo '<option value="'.e($k).'" '.((string)$k===(string)$selected?'selected':'').'>'.e($v).'</option>'; echo '</select></label>'; }
function csrf_field(): void { echo '<input type="hidden" name="csrf" value="'.e(csrf()).'">'; }
function money(int $paise): string { return '₹'.number_format($paise/100,$paise%100===0?0:2); }
function empty_state(string $title,string $body): void { echo '<div class="empty"><span class="empty-icon">↗</span><h3>'.e($title).'</h3><p>'.e($body).'</p></div>'; }
function table(array $columns,array $records): void { echo '<div class="table-wrap"><table><thead><tr>'; foreach($columns as $label) echo '<th>'.e($label).'</th>'; echo '</tr></thead><tbody>'; foreach($records as $r) { echo '<tr>'; foreach($columns as $key=>$label) echo '<td>'.e(is_array($r[$key]??null)?json_encode($r[$key]):($r[$key]??'—')).'</td>'; echo '</tr>'; } echo '</tbody></table></div>'; if (!$records) empty_state('Nothing here yet','Your data will appear here as you use this workspace.'); }
