<?php $brand=$s['branding']??[];$color=preg_match('/^#[0-9a-f]{6}$/i',$brand['brand_color']??'')?$brand['brand_color']:'#ff7a00';?>
<svg width="100%" height="5" viewBox="0 0 1000 5" aria-hidden="true"><rect width="1000" height="5" fill="<?=e($color)?>"/></svg>
<?php if(str_starts_with($brand['logo_data']??'','data:image/png;base64,')):?><p><img src="<?=e($brand['logo_data'])?>" alt="<?=e($brand['agency_name']??'Agency')?> logo" width="150"></p><?php endif;?>
<?php if(!empty($brand['agency_contact'])||!empty($brand['agency_website'])):?><p class="small"><?=e($brand['agency_contact']??'')?> · <?=e($brand['agency_website']??'')?></p><?php endif;?>
