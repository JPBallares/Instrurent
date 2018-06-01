<?php

function OpenCon()
 {
 $dbhost = "database";
 $dbuser = "root";
 $dbpass = "test";
 $db = "tenterent";


 $conn = new mysqli($dbhost, $dbuser, $dbpass,$db) or die("Connect failed: %s\n". $conn -> error);

 
 return $conn;
 }
 
function CloseCon($conn)
 {
 $conn -> close();
 }
   
?>