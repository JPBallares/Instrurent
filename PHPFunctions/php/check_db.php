<?php
include 'access_db.php';
 
$conn = OpenCon();
 
echo "Connected Successfully";
 
CloseCon($conn);
 
?>