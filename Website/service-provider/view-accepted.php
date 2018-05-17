<?php
    session_start();
    
    if (!isset($_SESSION['provider_loggedin'])){
        echo "
            <script>
                alert('You\'re not logged in as service provider');
                window.location = 'http://www.tenterent.com:8082';
            </script>
        ";
    } else {
?>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>TentERent | Service-Provider</title>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="shortcut icon" href="./css/img/Logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="./css/main.css"/>
	<link rel="stylesheet" href="style/sp-index.css">
	<link rel="stylesheet" href="style/sp-notifications.css">
    <!-- Bootstrap -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <script src="./js/jquery.min.js"></script>
    <script src="./js/bootstrap.min.js"></script>
	<script src="./js/popper.min.js"></script>
	<!-- Bootstrap -->
    <!-- Fontawesome -->
    <link rel="stylesheet" href="style/web-fonts-with-css/css/fontawesome-all.min.css">
    <!-- Fontawesome -->
</head>
    
<body>
    <nav class="navbar navbar-dark bg-dark fixed-top navbar-expand-lg">
    <a class="navbar-brand" href="#"><img src="./css/img/Logo.png" class="logo_s">TentERent</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav nav-item-sp ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Account
                </a>
                <div class="dropdown-menu dropdown-menu-sp dropdown-menu-right" aria-labelledby="navbarDropdown">
					<h6 class="dropdown-header"><?php echo $_SESSION['name'];?></h6>
                    <a class="dropdown-item" href="edit_profile.php">Profile</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="php/logout.php">Log out</a>
                </div>
            </li>
			<li class="nav-item nav-item-sp">
            	<a class="nav-link" href="view-accepted"><i class="fa fa-envelope"></i></a>
            </li>
			<li class="nav-item nav-item-sp">
            	<a class="nav-link" href="view-transaction"><i class="fas fa-bell"></i></a>
            </li>
        </ul>
    </div>
    </nav>
	
    <br>
    <br>
    <br>
    <br>
    <br>
	<?php include 'php/view_accepted.php';?>
	
	
	<script src="scripts/sp-randomizer.js"></script>
</body>
</html>
<?php
    }
?>