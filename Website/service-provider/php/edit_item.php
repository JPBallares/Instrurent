<?php
include 'access_db.php';

$conn = OpenCon();

$item_id = $_GET['item_id'];

$sql = "SELECT *  FROM `items` NATURAL JOIN `item_type` WHERE item_id = $item_id";
$result = $conn->query($sql);
while ($row = $result->fetch_assoc()) {
    $item_name = $row['item_name'];
    $price = $row['price'];
    $renting_fee = $row['renting_fee'];
    $stock = $row['stock'];
    $item_image = $row['item_image'];
    $type_id = $row['type_id'];
}

CloseCon($conn);
?>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <title>TentERent | Service-Provider</title>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <link rel="shortcut icon" href="/css/img/Logo.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="style/sp-index.css">
        <!-- Bootstrap -->
        <link rel="stylesheet" href="/css/bootstrap.min.css">
        <script src="/js/jquery.min.js"></script>
        <script src="/js/bootstrap.min.js"></script>
        <script src="/js/popper.min.js"></script>
        <!-- Bootstrap -->
        <!-- Fontawesome -->
        <link rel="stylesheet" href="/style/web-fonts-with-css/css/fontawesome-all.min.css">
        <!-- Fontawesome -->
    </head>

    <body>
        <div id="edit-item-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Item</h5>
                    </div>
                    <div class="modal-body">
                        <form action="/php/update_item.php" method="POST" enctype="multipart/form-data">
                            <input name="item_id" value="<?php echo $item_id;?>" type="hidden">
                            <div class="form-group">
                                <label for="item-image">Image</label>
                                <input name="file" type="file" class="form-control" id="item_image" placeholder="Item Image" accept="image/*">
                            </div>
                            <div class="form-group">
                                <label for="item-name">Name</label>
                                <input value="<?php echo $item_name;?>" name="item-name" type="text" class="form-control" id="item_name" placeholder="Item Name">

                            </div>
                            <div class="form-group">
                                <label for="item-price">Price</label>
                                <input value="<?php echo $price;?>" name="item-price" type="text" class="form-control" id="item_price" placeholder="Item Price">
                            </div>
                            <div class="form-group">
                                <label for="item-fee">Renting Fee</label>
                                <input value="<?php echo $renting_fee;?>" name="item-fee" type="text" class="form-control" id="item_fee" placeholder="Item Fee">
                            </div>
                            <div class="form-group">
                                <label for="item-quantity">Quantity</label>
                                <input value="<?php echo $stock;?>" name="item-quantity" type="text" class="form-control" id="item_quantity" placeholder="Item Quantity">
                            </div>
                            <div class="form-group">
                                <label for="item-type">Type</label>
                                <select name='type-id'>
                                <?php
                                include 'display_types.php';
                                ?>
                                <option value="<?php echo $type_id;?>" selected="selected"></option>
                                </select>
                            </div>
                            <div class="modal-footer">
                                <input type="submit" class="btn btn-primary sp-btn btn_cc" value="Update">
                                <button type="button" class="btn btn-secondary sp-btn" data-dismiss="modal">Close</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>