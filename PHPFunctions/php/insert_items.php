<?php
include 'access_db.php';
$conn = OpenCon();

$item_name = $_POST['item_name'];
$price = $_POST['price'];
$renting_fee = $_POST['renting_fee'];
$stock = $_POST['stock'];
$item_image = $_FILES['file']['tmp_name'];
$item_image = file_get_contents($item_image);
$provider_id = $_POST['provider_id'];
$item_type_id = $_POST['item_type_id'];

$item_name = mysqli_real_escape_string($conn, $item_name);
$price = mysqli_real_escape_string($conn, $price);
$renting_fee = mysqli_real_escape_string($conn, $renting_fee);
$stock = mysqli_real_escape_string($conn, $stock);
$item_image = mysqli_real_escape_string($conn, $item_image);
$provider_id = mysqli_real_escape_string($conn, $provider_id);
$item_type_id = mysqli_real_escape_string($conn, $item_type_id);

if (empty($item_name) || empty($price) || empty($renting_fee) || empty($stock) || empty($item_image)
    || empty($provider_id) || empty($item_type_id)) {
    echo "
        <script>
            alert('You must fill up all neccessary fields.');
            window.history.back();
        </script>
    ";
    exit;
}


$query = "";

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