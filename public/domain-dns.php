<?php
$title=DomainDns::settings()['name'];require ROOT.'/includes/header.php';
?>
<main id="main"><div class="container section-pad"><a href="<?=url('/')?>">&larr; Home</a><h1><?=e($title)?></h1></div><?php require ROOT.'/public/domain-dns-form.php';?></main>
<?php require ROOT.'/includes/footer.php';?>
