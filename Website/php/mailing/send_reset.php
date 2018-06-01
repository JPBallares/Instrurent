<?php
session_start();
// Import PHPMailer classes into the global namespace
// These must be at the top of your script, not inside a function
use PHPMailer\PHPMailer\Exception;
use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;

//Load Composer's autoloader
require 'vendor/autoload.php';
include 'access_db.php';
$conn = OpenCon();

$email = $_POST['email'];
$email = mysqli_real_escape_string($conn, $email);

$sql = "SELECT * FROM accounts where email = '$email';";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $password = $row['password'];
        $username = $row['username'];
    }
} else {
    echo "
            <script>
                alert('That email is not being used by any account.');
                window.history.back();
            </script>
        ";
}

$developmentMode = true;
$mail = new PHPMailer($developmentMode); // Passing `true` enables exceptions
try {
    //Server settings
    $mail->SMTPDebug = 0; // Enable verbose debug output
    $mail->isSMTP(); // Set mailer to use SMTP
    if ($developmentMode) {
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true,
            ),
        );
    }
    $mail->Host = 'smtp.gmail.com'; // Specify main and backup SMTP servers
    $mail->SMTPAuth = true; // Enable SMTP authentication
    $mail->Username = 'xitle.xitler@gmail.com'; // SMTP username
    $mail->Password = '@Xitle.gmail.com'; // SMTP password
    $mail->SMTPSecure = 'ssl'; // Enable TLS encryption, `ssl` also accepted
    $mail->Port = 465; // TCP port to connect to

    //Recipients
    $mail->setFrom('xitle.xitler@gmail.com', 'Tenterent');
    // $mail->addAddress('joe@example.net', 'Joe User');     // Add a recipient
    $mail->addAddress($email); // Name is optional
    // $mail->addReplyTo('zenad.scarlet@gmail.com', 'Information');
    // $mail->addCC('cc@example.com');
    // $mail->addBCC('bcc@example.com');

    //Attachments
    // $mail->addAttachment('/var/tmp/file.tar.gz');         // Add attachments
    // $mail->addAttachment('/tmp/image.jpg', 'new.jpg');    // Optional name

    //Content
    $body = file_get_contents("style.html");
    $body .= "<div id='main_content'>";
    $body .= "
    <h1>Reset Your Password</h1>
    <p>You have requested to reset your password in our site, to continue click on the link below.</p>
    ";
    $body .= "<a class='pure-button pure-button-primary' href='www.tenterent.com/password.php?account=" . $username . "." . $password . "'>Reset My Tenterent Password</a>";
    $body .= "<p>If you didn't request for reset password, ignore this message</p>";
    $body .= "</div>";

    $mail->isHTML(true); // Set email format to HTML
    $mail->Subject = 'Tenterent Reset Password';
    $mail->Body = $body;
    $mail->AltBody = 'You have requested for changing password';

    $mail->send();
    $mail->ClearAllRecipients();

    echo "
    <script>
    alert('Email sucessfully sent, please check your email.');
    location.href = '/';
    </script>";
} catch (Exception $e) {
    echo 'Message could not be sent. Mailer Error: ', $mail->ErrorInfo;
}
