<?php
include 'access_db.php';
$conn = OpenCon();

$item_name = $_POST['first_name'];
$last_name = $_POST['first_name'];
$address1 = $_POST['address1'];
$address2 = $_POST['address2'];
$email = $_POST['email'];
$username = $_POST['username'];
$password = $_POST['password'];
$contact_number = $_POST['contact_number'];

$first_name = mysqli_real_escape_string($conn, $first_name);
$last_name = mysqli_real_escape_string($conn, $last_name);
$address1 = mysqli_real_escape_string($conn, $address1);
$address2 = mysqli_real_escape_string($conn, $address2);
$email = mysqli_real_escape_string($conn, $email);
$username = mysqli_real_escape_string($conn, $username);
$password = mysqli_real_escape_string($conn, $password);
$contact_number = mysqli_real_escape_string($conn, $contact_number);
$password = mysqli_real_escape_string($conn, $registered);

if (empty($first_name) || empty($last_name) || empty($address1) || empty($email) || empty($username)
    || empty($password) || empty($contact_number)) {
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