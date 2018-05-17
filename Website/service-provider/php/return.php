<?php
include 'access_db.php';

$conn = OpenCon();

$transaction_id = $_GET['trans_id'];
$transaction_id = mysqli_real_escape_string($conn, $transaction_id);

$sql = "SELECT *  FROM transaction NATURAL JOIN customer NATURAL JOIN items WHERE transaction_id = $transaction_id AND approved = 'p';";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $item_id = $row['item_id'];
    $stock = $row['stock'];
    $quantity = $row['quantity'];
    $sql2 = "UPDATE `items` SET `stock` = '" . ($stock + $quantity) . "' WHERE `items`.`item_id` = $item_id;";
    if ($conn->query($sql2) === TRUE) {
        
    } else {
        echo "Error updating record: " . $conn->error;
    }
}

$sql = "UPDATE `transaction` SET `approved` = 'a' WHERE `transaction_id` = $transaction_id;";
if ($conn->query($sql) === TRUE) {
    echo "
    <script>
    alert('The transaction has been accepted');
    window.history.back();
    </script>
    ";
} else {
    echo "Error updating record: here" . $conn->error;
}

CloseCon($conn);
