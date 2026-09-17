<?php
final class Launch {
 public static function ready(): bool {try{return (bool)value("SHOW TABLES LIKE 'zentro_posts'");}catch(Throwable){return false;}}
 public static function migrate(): void {
  query("CREATE TABLE IF NOT EXISTS zentro_posts (id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, slug VARCHAR(160) NOT NULL UNIQUE, title VARCHAR(180) NOT NULL, description VARCHAR(320) NOT NULL, content MEDIUMTEXT NOT NULL, image VARCHAR(500) NOT NULL DEFAULT '', image_alt VARCHAR(200) NOT NULL DEFAULT '', status VARCHAR(20) NOT NULL DEFAULT 'draft', published_at DATETIME NULL, updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
  query("CREATE TABLE IF NOT EXISTS zentro_leads (id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY, source VARCHAR(30) NOT NULL, fingerprint CHAR(64) NOT NULL, business_name VARCHAR(250) NOT NULL, phone VARCHAR(100) NOT NULL DEFAULT '', website VARCHAR(1000) NOT NULL DEFAULT '', address VARCHAR(1000) NOT NULL DEFAULT '', listing_url VARCHAR(1000) NOT NULL DEFAULT '', created_by INT NOT NULL, created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, UNIQUE KEY source_lead(source,fingerprint)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4");
 }
 public static function posts(): array {return self::ready()?rows("SELECT * FROM zentro_posts WHERE status='published' ORDER BY published_at DESC LIMIT 1000"):[];}
 public static function safeUrl(mixed $v): string {return is_string($v)&&filter_var($v,FILTER_VALIDATE_URL)&&in_array(strtolower((string)parse_url($v,PHP_URL_SCHEME)),['http','https'],true)?mb_substr($v,0,1000):'';}
 public static function upload(): string {
  $f=$_FILES['image']??null;if(!$f||$f['error']===UPLOAD_ERR_NO_FILE)return '';
  if($f['error']!==UPLOAD_ERR_OK||$f['size']>4000000||!is_uploaded_file($f['tmp_name']))fail('Upload a JPG, PNG or WebP image up to 4 MB.');
  $info=@getimagesize($f['tmp_name']);if(!$info||!in_array($info[2],[IMAGETYPE_JPEG,IMAGETYPE_PNG,IMAGETYPE_WEBP])||$info[0]*$info[1]>16000000)fail('Use an image below 16 megapixels.');
  $src=@imagecreatefromstring(file_get_contents($f['tmp_name']));if(!$src)fail('Image could not be read.');
  $dir=ROOT.'/assets/uploads';if(!is_dir($dir))mkdir($dir,0755,true);$path='/assets/uploads/'.bin2hex(random_bytes(16)).'.webp';
  if(!imagewebp($src,ROOT.$path,85))fail('Image could not be saved.',500);imagedestroy($src);return $path;
 }
}
