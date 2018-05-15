<?php
include 'access_db.php';

$conn = OpenCon();
session_start();
$provider_id = $_SESSION['provider_id'];

$sql = "SELECT provider_id, provider_name, transaction_id, item_id, item_name, date_rented, date_due, amount, approved, cust_id, first_name, last_name  FROM transaction NATURAL JOIN customer NATURAL JOIN service_provider NATURAL JOIN items WHERE approved = 0 AND provider_id = '$provider_id'";
$result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // output data of each row
        echo "<table>" .
        "<tr>" .
        "<thTransaction ID</th>" . 
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
            "<td><a href='/accept.php?trans_id=" . $row['transaction_id'] . "'>
            <a href='/reject.php?trans_id=" . $row['transaction_id'] . "'></td>" .
            "</tr>";
        }
        echo "</table>";
    }

CloseCon($conn);
