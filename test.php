<?php
$image_data = file_get_contents("logox2.png");
$encoded_image = base64_encode($image_data);

$Hinh = "<img src='data:image/jpeg;base64,{$encoded_image}'>";

//and you echo $Hinh
echo $Hinh;
?>