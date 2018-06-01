<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>TentERent | Change Password</title>
    <link rel="shortcut icon" href="css/img/Logo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="css/main.css" />
    <link rel="stylesheet" href="css/validate.css" />

    <!-- Bootstrap -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/popper.min.js"></script>
    <!-- Bootstrap -->
    <script src="js/ajax.js"></script>

</head>

<body>
    <!-- Login -->
    <div id="reset" tabindex="-1" role="dialog" aria-labelledby="reset" >
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Reset Password</h5>
                </div>
                <form action="/php/reset_password" method="POST">
                    
                    <input name="account" type="text" style="display: none;" value="<?php echo $_GET['account'];?>">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="new_password">New Password</label>
                            <input name="password" type="password" class="form-control" id="new_password" placeholder="New Password">
                        </div>

                        <div class="form-group">
                            <label for="conf_password">Confirm Password</label>
                            <input name="conf_password" type="password" class="form-control" id="conf_password" placeholder="Confirm Password">
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="location.href = '/';">Cancel</button>
                        <input name="change" type="submit" class="btn btn-primary btn_cc" value="Change">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- Login -->
</body>