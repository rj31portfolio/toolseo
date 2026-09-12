<?php
final class Chart {
 public static function line(array $points,string $label): void {
  if(count($points)<2){empty_state('More data will reveal the trend.','At least two recorded dates are needed.');return;}$values=array_column($points,'value');$max=max(1,max($values));$coords=[];foreach($points as $i=>$p)$coords[]=(35+$i*630/(count($points)-1)).','.(190-160*$p['value']/$max);
  echo '<svg viewBox="0 0 700 230" class="chart" role="img" aria-label="'.e($label).'"><path class="chart-grid" d="M35 30H670 M35 70H670 M35 110H670 M35 150H670 M35 190H670"/><text x="0" y="35">'.e($max).'</text><text x="0" y="193">0</text><polyline class="chart-line" points="'.e(implode(' ',$coords)).'"/><text x="35" y="220">'.e($points[0]['label']).'</text><text x="580" y="220">'.e(end($points)['label']).'</text></svg>';
 }
 public static function bars(array $values,string $label): void { if(!$values){empty_state('No recorded data','Run an audit or import data to populate this chart.');return;}$max=max(1,max($values));echo '<svg viewBox="0 0 600 '.(count($values)*38+15).'" role="img" aria-label="'.e($label).'">';$y=0;foreach($values as $name=>$value){$y+=38;echo '<text x="0" y="'.$y.'" font-size="12" fill="#676b62">'.e($name).'</text><rect x="130" y="'.($y-15).'" width="'.(400*$value/$max).'" height="20" rx="4" fill="#ff7a00"/><text x="550" y="'.$y.'" font-size="12">'.e($value).'</text>';}echo '</svg>';}
}
