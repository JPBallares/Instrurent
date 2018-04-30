<?php
include 'access_db.php';
$conn = OpenCon();

$first_name = $_POST['first_name'];
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

if (!preg_match("/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/", $user_email)) {
    echo "
        <script>
            alert('Invalid Email');
            window.history.back();
        </script>
    ";
    exit;
}

if (!preg_match("^\+639[0-9]{9}$|^09[0-9]{9}$", $contact_number)) {
    echo "
        <script>
            alert('Invalid Contact Number');
            window.history.back();
        </script>
    ";
    exit;
}

$sql = "SELECT * FROM users where user_email = '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "
        <script>
            alert('Email address that you have entered is already in use.');
            window.history.back();
        </script>
    ";
    exit;
}

$sql = "SELECT * FROM users where user_email = '$username'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "
        <script>
            alert('Username that you have entered is already taken.');
            window.history.back();
        </script>
    ";
    exit;
}

if (strlen($password) < 8 || strlen($password) > 20) {
    echo "
        <script>
            alert('Password length must be greater than 8 and less than 20 characters,');
            window.history.back();
        </script>
    ";
    exit;
}

$user_pass = sha1($user_pass);

$query = "INSERT INTO `client` (`client_id`, `first_name`, `last_name`, `address1`, `address2`, `email`, `username`, `password`, `contact_number`, `registered`)
VALUES (NULL, '$first_name', '$last_name', '$address1', '$address2', '$email', '$username', '$password', '$contact_number', '0');";

if ($conn->query($query) === true) {
    echo "
        <script>
            alert('You are now registered.');
            window.location.replace('/');
        </script>
    ";
} else {
    echo "Error: " . $query . "<br>" . $conn->error;
}

CloseCon($conn);
?>