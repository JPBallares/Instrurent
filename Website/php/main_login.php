<style>
    body{
        display: none;
    }
</style>

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
                switch ($row['activate']) {
                    case "inactive":
                        echo "
                        <script>
                            alert('Your account is deactivated by the admin.');
                            window.location.replace('/');
                        </script>
                        ";
                        break;
                    default:
                        
                        break;
                }
                
                switch ($row['status']) {
                    case "r":
                        echo "
                        <script>
                            alert('Registration rejected by admin.');
                            window.location.replace('/');
                        </script>
                        ";
                        break;
                    case "p":
                        echo "
                        <script>
                            alert('Your account is still pending.');
                            window.location.replace('/');
                        </script>
                        ";
                        break;
                    case "a":
                        switch ($row['account_type']) {
                            case "sa":
                                $password = $_POST['password'];
                                echo "
                                <form method='POST' action='http://admin.tenterent.com/WebtechLecFinals/LoginServlet' id='login_form'>
                                <input type='text' name='username' value='$username'>
                                <input type='password' name='password' value='$password'>
                                <input type='submit' value='login' name='login'>
                                </form>
                                ";
                                break;
                            case "sp":
                                $password = $_POST['password'];
                                echo "
                                <form method='POST' action='http://provider.tenterent.com/php/sp_login.php' id='login_form'>
                                    <input type='text' name='username' value='$username'>
                                    <input type='password' name='password' value='$password'>
                                    <input type='submit' value='login' name='login'>
                                </form>
                                ";
                                break;
                            case "c":
                                $password = $_POST['password'];
                                echo "
                                <form method='POST' action='http://client.tenterent.com/login' id='login_form'>
                                    <input type='text' name='username' value='$username'>
                                    <input type='password' name='password' value='$password'>
                                    <input type='submit' value='login' name='login'>
                                </form>
                                ";
                                break;
                            case "a":
                                $password = $_POST['password'];
                                echo "
                                <form method='POST' action='http://admin.tenterent.com/WebtechLecFinals/LoginServlet' id='login_form'>
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
                        break;
                }

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
                alert('Account doesn\'t exist.');
                window.history.back();
            </script>
        ";

    }

} else {
    echo "Failed";
}

CloseCon($conn);
