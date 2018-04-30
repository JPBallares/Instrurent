<?php
include 'access_db.php';

$conn = OpenCon();
session_start();
$username = $_POST['username'];
$password = sha1($_POST['password']);

$username = mysqli_real_escape_string($conn, $username);
$password = mysqli_real_escape_string($conn, $password);

$sql = "SELECT * FROM accounts where username = '$username';";
$result = $conn->query($sql);
if (isset($_POST['login'])) {

    if ($result->num_rows > 0) {
        // output data of each row
        while ($row = $result->fetch_assoc()) {
            if ($row['password'] == $password) {

                switch ($row['account_type']) {
                    case "sa":
                        break;
                    case "sp":
                        $password = $_POST['password'];
                        echo "
                        <form method='POST' action='http://localhost:8084/SampleWeb/SampleServlet' id='login_form'>
                            <input type='text' name='username' value='$username'>
                            <input type='password' name='password' value='$password'>
                            <input type='submit' value='login' name='login'>
                        </form>
                        ";
                        break;
                    case "c":
                        break;
                    case "a":
                        $password = $_POST['password'];
                        echo "
                        <form method='POST' action='login' id='login_form'>
                            <input type='text' name='username' value='$username'>
                            <input type='password' name='password' value='$password'>
                            <input type='submit' value='login' name='login'>
                        </form>
                        ";
                        break;
                }
                echo "
                <script>
                window.onload = function(){
                    document.getElementById('login_form').submit();
                }
                </script>
                ";
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

} else {
    echo "Failed";
}

CloseCon($conn);
