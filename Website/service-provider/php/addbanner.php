<?php
include 'access_db.php';
session_start();
$conn = OpenCon();

$banner = file_get_contents($_FILES['file']['tmp_name']);
$provider_id = $_SESSION['provider_id'];

$sql = $conn->prepare("UPDATE `service_provider` SET `banner` = ? WHERE `provider_id` = ?;");
$sql->bind_param("bi", $banner, $provider_id);
$sql->execute();
$sql->close();
$conn->autocommit(true);
$_SESSION['banner'] = $banner;
echo "
    <script>
    alert('Banner has been added');
    window.history.back();
    </script>
    ";

CloseCon($conn);
