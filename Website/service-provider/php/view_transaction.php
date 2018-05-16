<?php
include 'access_db.php';

$conn = OpenCon();
if (!isset($_SESSION)) {
    session_start();
}
$provider_id = $_SESSION['provider_id'];

$sql = "SELECT *  FROM transaction NATURAL JOIN customer NATURAL JOIN items WHERE approved = 'p' AND provider_id = '$provider_id';";
$result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // output data of each row
        echo "<table>" .
        "<tr>" .
        "<th>Transaction ID</th>" . 
        "<th>Item Name</th>" .
        "<th>Date Rented</th>" .
        "<th>Date Due</th>" .
        "<th>Amount</th>" .
        "<th>Customer Name</th>" .
        "<th>Accept/Reject</th>" .
        "</tr>";
        while ($row = $result->fetch_assoc()) {
            echo "<tr>" .
            "<td>" . $row['transaction_id'] . "</td>" .
            "<td>" . $row['item_name'] . "</td>" .
            "<td>" . $row['date_rented'] . "</td>" .
            "<td>" . $row['date_due'] . "</td>" .
            "<td>" . $row['amount'] . "</td>" .
            "<td>" . $row['first_name'] . " " . $row['last_name'] . "</td>" .
            "<td><a href='/php/accept.php?trans_id=" . $row['transaction_id'] . "'>Accept</a>
            <a href='/php/reject.php?trans_id=" . $row['transaction_id'] . "'>Reject</a></td>" .
            "</tr>";
        }
        echo "</table>";
    }

CloseCon($conn);
