<?php
include 'access_db.php';
$conn = OpenCon();

$first_name = $_POST['client_first_name'];
$last_name = $_POST['client_last_name'];
$gender = $_POST['gender'];
$birthdate = $_POST['birth_date'];
$username = $_POST['client_username'];
$address = $_POST['client_address'];
$contact = $_POST['client_contact'];
$email = $_POST['client_email'];
$password = $_POST['client_pass'];
$account_type = 'c';

 if (!preg_match("/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/", $email)) {
     echo "
         <script>
             alert('Invalid Email');
             window.history.back();
         </script>
     ";
     exit;
 }

 if (!preg_match("/^09[0-9]{9}$/", $contact)) {
     echo "
         <script>
             alert('Invalid Contact Number');
             window.history.back();
         </script>
     ";
     exit;
 }

 $sql = "SELECT * FROM accounts where email = '$email'";
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

 $sql = "SELECT * FROM accounts where username = '$username'";
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

$password = sha1($password);

$insert_stmt = "INSERT INTO `accounts` (`account_id`, `email`, `username`, `password`, `account_type`) VALUES (NULL, '$email', '$username', '$password', '$account_type');";

$sql = "SELECT * FROM accounts ORDER BY account_id DESC LIMIT 1;";

if ($conn->query($insert_stmt) === true) {
    $result = $conn->query($sql);
    while ($row = $result->fetch_assoc()) {
        $accountid = $row['account_id'];
    }
    $insert_stmt = "INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `address`, `birthdate`, `contact_number`, `accepted`, `account_id`) VALUES (NULL, '$first_name', '$last_name', '$address', '$birthdate', '$contact', 'p', '$accountid');";
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
