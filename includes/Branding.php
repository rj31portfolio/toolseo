<?php
final class Branding {
 public static function logo(string $url): string {
  $response=SafeHttp::request($url);if($response['status']!==200)fail('Logo could not be fetched.');$info=@getimagesizefromstring($response['body']);if(!$info||!in_array($info[2],[IMAGETYPE_JPEG,IMAGETYPE_PNG,IMAGETYPE_WEBP])||$info[0]*$info[1]>16000000)fail('Use a JPEG, PNG or WebP logo below 16 megapixels.');$src=@imagecreatefromstring($response['body']);if(!$src)fail('Invalid logo image.');$ratio=min(1,300/$info[0],120/$info[1]);$width=max(1,(int)($info[0]*$ratio));$height=max(1,(int)($info[1]*$ratio));$dst=imagecreatetruecolor($width,$height);imagealphablending($dst,false);imagesavealpha($dst,true);imagefill($dst,0,0,imagecolorallocatealpha($dst,255,255,255,127));imagecopyresampled($dst,$src,0,0,0,0,$width,$height,$info[0],$info[1]);ob_start();imagepng($dst,null,9);$png=ob_get_clean();imagedestroy($src);imagedestroy($dst);if(strlen($png)>45000)fail('Logo is too complex. Use a smaller image.');return 'data:image/png;base64,'.base64_encode($png);
 }
}
