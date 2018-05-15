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
        <link rel="stylesheet" href="./css/main.css" />
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
        <script src="js/ajax.js"></script>
    </head>

    <body>
        <nav class="navbar navbar-dark bg-dark fixed-top navbar-expand-lg">
            <a class="navbar-brand" href="#">
                <img src="./css/img/Logo.png" class="logo_s">TentERent</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav nav-item-sp ml-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                            Account
                        </a>
                        <div class="dropdown-menu dropdown-menu-sp dropdown-menu-right" aria-labelledby="navbarDropdown">
                            <h6 class="dropdown-header">
                                <?php echo $_SESSION['name'];?>
                            </h6>
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="#">Account Information</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="php/logout.php">Log out</a>
                        </div>
                    </li>
                    <li class="nav-item nav-item-sp">
                        <a class="nav-link" href="">
                            <i class="fa fa-envelope"></i>
                        </a>
                    </li>
                    <li class="nav-item nav-item-sp">
                        <a class="nav-link" href="notifications.html">
                            <i class="fas fa-bell"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>
        
        <br>
        <br>
        <br>


        <form>
            <div class="modal-body">
                <div class="form-row">
                    <div class="col-md-4 mb-3">
                        <label for="service_name">Provider name</label>
                        <input name="service_name" type="text" class="form-control" id="service_name" placeholder="Name" required>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label for="service_username">Username</label>
                        <input name="service_username" type="text" class="form-control" id="service_username" placeholder="Username" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="service_address">Address</label>
                        <input name="service_address" type="text" class="form-control" id="service_address" placeholder="House No, Street, Barangay, City, Province"
                            onkeyup="showHint('address', this.value, 'addressValidateSP')" required>
                        <div id="addressValidateSP"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="service_email">Email Address</label>
                        <input name="service_email" type="text" class="form-control" id="service_email" placeholder="Email Address" onkeyup="showHint('email', this.value, 'emailValidateSP')"
                            required>
                        <div id="emailValidateSP"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="service_pass">Password</label>
                        <input name="service_pass" type="password" class="form-control" id="service_pass" placeholder="Password" onkeyup="showHint('password', this.value, 'passwordValidateSP')"
                            required>
                        <div id="passwordValidateSP"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="service_pass">Confirm Password</label>
                        <input name="service_pass" type="password" class="form-control" id="service_confirm_pass" placeholder="Password" onkeyup="confirmPass('confirm', this.value, 'service_pass','confirmPassSP')"
                            required>
                        <div id="confirmPassSP"></div>
                    </div>
                </div>

                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label for="service_contact">Contact number</label>
                        <input name="service_contact" type="text" class="form-control" id="service_contact" placeholder="Contact number" onkeyup="showHint('contact', this.value, 'contactValidateSP')"
                            required>
                        <div id="contactValidateSP"></div>
                    </div>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <input type="submit" class="btn btn-primary btn_cc" value="Update" id="submitProvider">
            </div>
        </form>

        <div class="sp-divider"></div>

        <script src="scripts/sp-randomizer.js"></script>
    </body>

    </html>
    <?php
}
?>