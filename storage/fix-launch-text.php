<?php
require dirname(__DIR__).'/includes/bootstrap.php';
$map=[];foreach(['→','↗','←','©','·','—','–','’','☰','✓','✧','⌄'] as $symbol){$bad=$symbol;for($i=0;$i<3;$i++){$bad=mb_convert_encoding($bad,'UTF-8','Windows-1252');$map[$bad]=$symbol;}}
foreach(['includes/header.php','includes/footer.php','admin/index.php','admin/settings.php','index.php','api/admin.php','public/pricing-cards.php'] as $f){$s=file_get_contents(ROOT.'/'.$f);$s=strtr($s,$map);file_put_contents(ROOT.'/'.$f,$s);}
echo "Launch text encoding normalized.\n";
