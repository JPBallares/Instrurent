<?php
include 'access_db.php';

$conn = OpenCon();
if (!isset($_SESSION)) {
    session_start();
}

$provider_id = $_SESSION['provider_id'];
$sql = "select count(transaction_id) transac_count from transaction natural join items where approved = 'p' and provider_id = $provider_id;";

$result = $conn->query($sql);

if ($result->num_rows > 0) {

    while ($row = $result->fetch_assoc()) {
        if ($row['transac_count'] > 0) {
            echo "
            <script>
                alert('You have pending transaction');
            </script>
            ";
        }
    }
}

CloseCon($conn);
