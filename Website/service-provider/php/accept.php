<?php
include 'access_db.php';

$conn = OpenCon();

$transaction_id = $_GET['trans_id'];
$transaction_id = mysqli_real_escape_string($conn, $transaction_id);

$sql = "UPDATE `transaction` SET `approved` = 'a' WHERE `transaction_id` = $transaction_id;";
if ($conn->query($sql) === TRUE) {
    echo "
    <script>
    alert('The transaction has been accepted');
    window.history.back();
    </script>
    ";
} else {
    echo "Error updating record: " . $conn->error;
}

CloseCon($conn);
