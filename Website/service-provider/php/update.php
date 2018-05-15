<?php
include 'access_db.php';
session_start();
$conn = OpenCon();

$provider_id = $_SESSION['provider_id'];
$new_provider_name = $_POST['service_name'];
$new_contact = $_POST['service_contact'];
$new_address = $_POST['service_address'];

$account_id = $_SESSION['account_id'];
$new_email = $_POST['service_email'];
$new_username = $_POST['service_username'];
$new_password = $_POST['service_pass'];
$new_password = sha1($new_password);

$sql = "UPDATE `service_provider` SET `provider_name` = '$new_provider_name', `provider_contact` = '$new_contact', `provider_address` = '$new_address' WHERE `service_provider`.`provider_id` = $provider_id;";
$sql2 = "UPDATE `accounts` SET `email` = '$new_email', `username` = '$new_username', `password` = '$new_password' WHERE `accounts`.`account_id` = $account_id;";

if ($conn->query($sql) === TRUE && $conn->query($sql2) === TRUE) {
    $_SESSION['name'] = $new_provider_name;
    $_SESSION['contact'] = $new_contact;
    $_SESSION['address'] = $new_address;
    $_SESSION['email'] = $new_address;
    $_SESSION['username'] = $new_username;
    $_SESSION['password'] = $_POST['service_pass'];

    echo "
    <script>
    alert('Profile successfully updated');
    window.history.back();
    </script>
    ";
} else {
    echo "Error updating record: " . $conn->error;
}

CloseCon($conn);
