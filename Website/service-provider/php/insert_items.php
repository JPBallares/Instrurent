<?php
include 'access_db.php';
$conn = OpenCon();
session_start();

$item_name = $_POST['item-name'];
$price = $_POST['item-price'];
$renting_fee = $_POST['item-fee'];
$stock = $_POST['item-quantity'];
$item_image = $_FILES['file']['tmp_name'];
$item_image = file_get_contents($item_image);
$provider_id = $_SESSION['provider_id'];
$type_id = $_POST['type-id'];

$item_name = mysqli_real_escape_string($conn, $item_name);
$price = mysqli_real_escape_string($conn, $price);
$renting_fee = mysqli_real_escape_string($conn, $renting_fee);
$stock = mysqli_real_escape_string($conn, $stock);
$item_image = mysqli_real_escape_string($conn, $item_image);
$provider_id = mysqli_real_escape_string($conn, $provider_id);
$type_id = mysqli_real_escape_string($conn, $type_id);

if (empty($item_name) || empty($price) || empty($renting_fee) || empty($stock) || empty($item_image)
    || empty($type_id)) {
    echo "
        <script>
            alert('You must fill up all neccessary fields.');
            window.history.back();
        </script>
    ";
    exit;
}


$query = "INSERT INTO `tenterent`.`items` (`item_name`, `price`, `renting_fee`, `stock`, `type_id`, `provider_id`, `item_image`) VALUES ('$item_name', '$price', '$renting_fee', '$stock', '$type_id', '$provider_id', '$item_image');
";

if ($conn->query($query) === true) {
    echo "
        <script>
            alert('Item successfully added');
            window.location.replace('/');
        </script>
    ";
} else {
    echo "Error: " . $query . "<br>" . $conn->error;
}

CloseCon($conn);
?>