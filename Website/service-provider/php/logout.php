<?php
    session_start();
    session_unset();
    session_destroy();
    header("Location: http://www.tenterent.com:8082/");

    exit();
?>