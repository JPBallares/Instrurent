<?php
include 'access_db.php';

$conn = OpenCon();
session_start();
$username = $_POST['username'];
$password = sha1($_POST['password']);

$username = mysqli_real_escape_string($conn, $username);
$password = mysqli_real_escape_string($conn, $password);

$sql = "SELECT * FROM service_provider NATURAL JOIN accounts
        WHERE username = '$username';";
$result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // output data of each row
        while ($row = $result->fetch_assoc()) {
            if ($row['password'] == $password) {
                $_SESSION['provider_loggedin'] = true;
                $_SESSION['provider_id'] = $row['provider_id'];
                $_SESSION['name'] = $row['provider_name'];
                $_SESSION['contact'] = $row['provider_contact'];
                $_SESSION['address'] = $row['provider_address'];
                $_SESSION['account_id'] = $row['account_id'];
                $_SESSION['username'] = $row['username'];
                $_SESSION['email'] = $row['email'];
                $_SESSION['password'] = $_POST['password'];
                $_SESSION['banner'] = $row['banner'];
                header('Location: http://provider.tenterent.com');
                exit;

            } else {

                echo "
                    <script>
                        alert('Wrong password.');
                        window.history.back();
                    </script>
                ";

            }
        }
    } else {
        echo "
            <script>
                alert('Account doesn't exist.);
                window.history.back();
            </script>
        ";
    }




CloseCon($conn);
