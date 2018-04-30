<?php
include 'access_db.php';
$conn = OpenCon();

$provider_name = $_POST['provider_name'];
$address = $_POST['address'];
$contact = $_POST['contact'];
$email = $_POST['email'];
$username = $_POST['username'];
$password = $_POST['password'];
$account_type = 'sp';

$provider_name = mysqli_real_escape_string($conn, $provider_name);
$address = mysqli_real_escape_string($conn, $address);
$contact = mysqli_real_escape_string($conn, $contact);
$email = mysqli_real_escape_string($conn, $email);
$username = mysqli_real_escape_string($conn, $username);
$password = mysqli_real_escape_string($conn, $password);

// if (empty($provider_name) || empty($address) || empty($email) || empty($username)
//     || empty($password) || empty($contact)) {
//     echo "
//         <script>
//             alert('You must fill up all neccessary fields.');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

// if (!preg_match("/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/", $user_email)) {
//     echo "
//         <script>
//             alert('Invalid Email');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

// if (!preg_match("^\+639[0-9]{9}$|^09[0-9]{9}$", $contact)) {
//     echo "
//         <script>
//             alert('Invalid Contact Number');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

// $sql = "SELECT * FROM accounts where user_email = '$email'";
// $result = $conn->query($sql);

// if ($result->num_rows > 0) {
//     echo "
//         <script>
//             alert('Email address that you have entered is already in use.');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

// $sql = "SELECT * FROM accounts where username = '$username'";
// $result = $conn->query($sql);

// if ($result->num_rows > 0) {
//     echo "
//         <script>
//             alert('Username that you have entered is already taken.');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

// if (strlen($password) < 8 || strlen($password) > 20) {
//     echo "
//         <script>
//             alert('Password length must be greater than 8 and less than 20 characters,');
//             window.history.back();
//         </script>
//     ";
//     exit;
// }

$password = sha1($password);

$insert_stmt = "INSERT INTO `tenterent`.`accounts` (`email`, `username`, `password`, `account_type`) VALUES ('$email', '$username', '$password', '$account_type');";

$sql = "SELECT * FROM accounts ORDER BY account_id DESC LIMIT 1;";

if ($conn->query($insert_stmt) === true) {
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        $accountid = $row['account_id'];
    }
    $insert_stmt = "INSERT INTO `tenterent`.`service_provider` (`provider_name`, `provider_contact`, `provider_address`, `accountid`) VALUES ('$provider_name', '$contact', '$address', '$accountid');";
    if ($conn->query($insert_stmt) === true) {
        echo "
        <script>
            alert('You are now registered.');
            window.location.replace('/');
        </script>
    ";
    } else {
        echo "Error: " . $query . "<br>" . $conn->error;
    }
} else {
    echo "Error: " . $query . "<br>" . $conn->error;
}

CloseCon($conn);
