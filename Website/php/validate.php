<?php
// get the q parameter from URL
$type = $_REQUEST["type"];

switch ($type) {
    case "email":
        $email = $_REQUEST["email"];
        if (!preg_match("/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/", $email)) {
            echo "<span class='invalid'>Invalid Email</span>";
        } else {
            echo "<span class='valid'>That looks good</span>";
        }
        break;
    case "contact":
        $contact_number = $_REQUEST["contact"];
        if (!preg_match("/^\+639[0-9]{9}$|^09[0-9]{9}$/", $contact_number)) {
            echo "<span class='invalid'>Invalid Contact Number, should be 09XXXXXXXXX or +63XXXXXXXXXX</span>";
        } else {
            echo "<span class='valid'>That looks good</span>";
        }
        break;
    case "password":
        $password = $_REQUEST["password"];
        if (strlen($password) < 8 || strlen($password) > 20) {
            echo "<span class='invalid'>Password length must be greater than 8 and less than 20 characters</span>";
        } else {
            echo "<span class='valid'>That looks good</span>";
        }
        break;
    case "address":
        $address = $_REQUEST["address"];
        if (!preg_match("/^([a-zA-Z0-9\.#\ ]+,){4}[a-zA-Z0-9\.#\ ]+/", $address)) {
            echo "<span class='invalid'>Doesn't contain necessary address information</span>";
        } else {
            echo "<span class='valid'>That looks good</span>";
        }   
    case "confirm":
        $confirmPass = $_REQUEST["confirmPass"];
        $password = $_REQUEST["password"];
        if ($password === $confirmPass){
            echo "<span class='invalid'>Password doesn't match.</span>";
        } else {
            echo "<span class='valid'>That looks good</span>";
        }
        break;

        
}
