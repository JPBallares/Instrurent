<?php
include 'access_db.php';
$conn = OpenCon();

$account = $_POST['account'];
$account = mysqli_real_escape_string($conn, $account);
$account = explode(".", $account);
$username = $account[0];
$old_password = $account[1];
$password = $_POST['password'];
$conf_password = $_POST['conf_password'];

if ($password != $conf_password){
    echo "
        <script>
            alert('Password don't match');
            window.location.replace('/');
        </script>
        ";
}

$sql = "SELECT * FROM accounts where username = '$username' AND password = '$old_password';";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $password = sha1($password);
    $update_stmt = "UPDATE `tenterent`.`accounts` SET `password`='$password' WHERE username = '$username' AND password = '$old_password';";
    if ($conn->query($update_stmt) === true) {
        echo "
        <script>
            alert('You have successfully changed your password.');
            window.location.replace('/');
        </script>
        ";
    } else {
        echo "
        <script>
            alert('Error in resetting your password, this link might be already expired.');
            window.location.replace('/');
        </script>
        ";
    }
} else {
    echo "
        <script>
            alert('Error in resetting your password, this link might be already expired.');
            window.location.replace('/');
        </script>
        ";
}
