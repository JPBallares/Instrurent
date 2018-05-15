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
                    <a class="dropdown-item" href="#">Profile</a>
                    <a class="dropdown-item" href="#">Account Information</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="php/logout.php">Log out</a>
                </div>
            </li>
			<li class="nav-item nav-item-sp">
            	<a class="nav-link" href=""><i class="fa fa-envelope"></i></a>
            </li>
			<li class="nav-item nav-item-sp">
            	<a class="nav-link" href="notifications.html"><i class="fas fa-bell"></i></a>
            </li>
        </ul>
    </div>
    </nav>
	
	<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>

        <div class="carousel-inner">
            <div class="carousel-item active" id="slide_1" style="background-position: 50% 30%;">
                <div class="carousel-caption d-none d-md-block">
                        <h5>...</h5>
                        <p>...</p>
                </div>
            </div>

            <div class="carousel-item" id="slide_2" style="background-position: 50% 80%;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>...</h5>
                    <p>...</p>
                </div>
            </div>

            <div class="carousel-item" id="slide_3" style="background-position: 50% 100%;">
                <div class="carousel-caption d-none d-md-block">
                    <h5>...</h5>
                    <p>...</p>
                </div>
            </div>
        </div>

        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>

        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
	
	<div class="container sp-container">
		<div class="row sp-row">
			<div class="col-md-6">
				<h3>Lorem</h3>
				<p style="text-indent: 3em;">Morbi ullamcorper, magna et efficitur semper, magna augue accumsan leo, a lobortis sapien risus non velit. Mauris viverra ante quis tempor pellentesque. Mauris vitae ornare sem. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam at commodo ante. Curabitur faucibus, massa non tempus venenatis, est augue elementum arcu, sed consequat lectus lorem sit amet risus. Quisque et congue ante. Phasellus metus mi, ornare id sollicitudin in, tincidunt in sem. Vivamus a ultrices metus, at rhoncus diam. Duis ac suscipit est, eget faucibus magna. Aenean rhoncus, justo a venenatis dapibus, nibh orci congue sem, at lobortis justo nibh in justo.</p>
			</div>
			<div class="col-md-6" id="sp-top-images">
				<img class="sp-image" src="images/sp-top-image-1.jpeg">
			</div>
		</div>
	</div>
	
<div class="container sp-items">
		<h3 class="sp-items-header">Items Owned</h3>
		<div class="cus-row">
			<div class="card cus-card" style="width: 300px; height: 350px;">
            <img class="card-img-top" src="img/slider_1.png" alt="Card image cap" style="width: 300px; height: 150px;">
                <div class="card-body">
                    <h5 class="card-title">Name</h5>
                    <p class="card-text">Price: </p>
                    <p class="card-text">Renting Fee: </p>
                    <p class="card-text">Stock: </p>
                </div>
            </div>
            
            <?php include 'query-owned-items.php'; ?>
            
            <div class="card cus-card add-card" style="width: 300px; height: 350px;">
                <div class="card-body add-item">
                    <a class="btn btn-primary btn-lg btn_cc" href="#" role="button" data-toggle="modal" data-target="#add-item-modal"><i class="fa fa-plus"></i></a>
                </div>
            </div>
            
            <div class="modal fade" id="add-item-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add New Item</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form action="" method="POST">
                                <div class="form-group">
                                    <label for="item-name">Name</label>
                                    <input name="item-name" type="text" class="form-control" id="item_name" placeholder="Item Name">
                                    
                                </div>
                                <div class="form-group">
                                    <label for="item-price">Price</label>
                                    <input name="item-price" type="text" class="form-control" id="item_price" placeholder="Item Price">
                                </div>
                                <div class="form-group">
                                    <label for="item-fee">Renting Fee</label>
                                    <input name="item-fee" type="text" class="form-control" id="item_fee" placeholder="Item Fee">
                                </div>
                                <div class="form-group">
                                    <label for="item-quantity">Quantity</label>
                                    <input name="item-quantity" type="text" class="form-control" id="item_quantity" placeholder="Item Quantity">
                                </div>
                                <div class="form-group">
                                    <label for="item-type">Type</label>
                                    <select>
                                        <option value="">1</option>
                                        <option value="">...</option>
                                        <option value="">15</option>
                                    </select>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary sp-btn btn_cc">Add Item</button>
                            <button type="button" class="btn btn-secondary sp-btn" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
		</div>
	</div>
	
	<div class="sp-divider"></div>
	
	<script src="scripts/sp-randomizer.js"></script>
</body>
</html>
<?php
}
?>