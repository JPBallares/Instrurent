<!--
<tr>
    <td>Item 2</td>
    <td>Week</td>
</tr>
<tr>
    <td>Item 3</td>
    <td>Month</td>
</tr>
<tr>
    <td>Item 4</td>
    <td>Year</td>
</tr>
<tr>
    <td>Item 5</td>
    <td>All Time</td>
</tr> -->
<?php
include 'access_db.php';

$conn = OpenCon();
if (!isset($_SESSION)) {
    session_start();
}
$provider_id = $_SESSION['provider_id'];

$sql = "SELECT item_name, SUM(quantity)  FROM transaction NATURAL JOIN items WHERE approved = 'a' AND provider_id = $provider_id GROUP BY item_id ORDER BY SUM(quantity) DESC LIMIT 1;";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        echo "
            <tr>
                <td>" . $row['item_name'] . "</td>
                <td>All Time</td>
            </tr>
            ";
    }
}

$sql = "SELECT item_name, SUM(quantity)  FROM transaction NATURAL JOIN items WHERE approved = 'a' AND YEAR(date_rented) = (YEAR(CURDATE())-1) AND provider_id = $provider_id GROUP BY item_id ORDER BY SUM(quantity) DESC LIMIT 1;";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        
        echo "
            <tr>
                <td>" . $row['item_name'] . "</td>
                <td>Last Year</td>
            </tr>
            ";
    }
}

$sql = "SELECT item_name, SUM(quantity)  FROM transaction NATURAL JOIN items WHERE approved = 'a' AND YEAR(date_rented) = YEAR(CURDATE()) AND provider_id = $provider_id GROUP BY item_id ORDER BY SUM(quantity) DESC LIMIT 1;";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        
        echo "
            <tr>
                <td>" . $row['item_name'] . "</td>
                <td>This Year</td>
            </tr>
            ";
    }
}

$sql = "SELECT item_name, SUM(quantity)  FROM transaction NATURAL JOIN items WHERE approved = 'a' AND MONTH(date_rented) = MONTH(CURDATE()) AND provider_id = $provider_id GROUP BY item_id ORDER BY SUM(quantity) DESC LIMIT 1;";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        
        echo "
            <tr>
                <td>" . $row['item_name'] . "</td>
                <td> Month of " . date('M') . "</td>
            </tr>
            ";
    }
}

$sql = "SELECT item_name, SUM(quantity)  FROM transaction NATURAL JOIN items WHERE approved = 'a' AND WEEK(date_rented) = WEEK(CURDATE()) AND YEAR(date_rented) = YEAR(CURDATE()) AND provider_id = $provider_id GROUP BY item_id ORDER BY SUM(quantity) DESC LIMIT 1;";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        
        echo "
            <tr>
                <td>" . $row['item_name'] . "</td>
                <td>This Week</td>
            </tr>
            ";
    }
}

CloseCon($conn);
