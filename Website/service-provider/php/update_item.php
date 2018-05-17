<?php
include 'access_db.php';

$conn = OpenCon();
$item_id = $_POST['item_id'];
$item_name = $_POST['item-name'];
$price = $_POST['item-price'];
$renting_fee = $_POST['item-fee'];
$stock = $_POST['item-quantity'];
if ($_FILES['file']['size'] > 0) {
    $item_image = $_FILES['file']['tmp_name'];
    $item_image = file_get_contents($item_image);
}

$provider_id = $_SESSION['provider_id'];
$type_id = $_POST['type-id'];

$item_id = mysqli_real_escape_string($conn, $item_id);
$item_name = mysqli_real_escape_string($conn, $item_name);
$price = mysqli_real_escape_string($conn, $price);
$renting_fee = mysqli_real_escape_string($conn, $renting_fee);
$stock = mysqli_real_escape_string($conn, $stock);
$item_image = mysqli_real_escape_string($conn, $item_image);
$provider_id = mysqli_real_escape_string($conn, $provider_id);
$type_id = mysqli_real_escape_string($conn, $type_id);

if ($_FILES['file']['size'] > 0) {
    $sql = "UPDATE `items` SET `item_image` = '$item_image', `item_name` = '$item_name', `price` = '$price', `renting_fee` = '$renting_fee', `stock` = '$stock', type_id = '$type_id' WHERE `items`.`item_id` = $item_id;";

} else {
    $sql = "UPDATE `items` SET `item_name` = '$item_name', `price` = '$price', `renting_fee` = '$renting_fee', `stock` = '$stock', type_id = '$type_id' WHERE `items`.`item_id` = $item_id;";
}
if ($conn->query($sql) === true) {
    echo "
    <script>
    alert('Successfully updated.');
    window.location = '/';
    </script>
    ";
    
} else {
    echo "
    <script>
    alert('Error updating record.');
    window.location = '/';
    </script>
    ";
}

CloseCon($conn);
