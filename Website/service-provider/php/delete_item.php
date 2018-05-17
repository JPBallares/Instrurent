<?php
include 'access_db.php';

$conn = OpenCon();

$item_id = $_GET['item_id'];

$sql = "DELETE FROM `items` WHERE `items`.`item_id` = $item_id";
if ($conn->query($sql) === TRUE) {
    echo "
    <script>
    alert('Item successfully deleted.');
    window.history.back();
    </script>
    ";
} else {
    echo "
    <script>
    alert('Can not delete the item, it is being used in other transaction.');
    window.history.back();
    </script>
    ";
}

CloseCon($conn);
