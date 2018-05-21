<?php
$con_db = new mysqli("localhost", "root", "", "tenterent");
$sql = "SELECT * from items WHERE provider_id = " . $_SESSION['provider_id'];
$res = $con_db->query($sql);

if ($res->num_rows > 0) {
    while ($row = $res->fetch_assoc()) {
        echo '<div class="card cus-card" style="width: 300px; height: 350px;">';

        echo '<div class="img-con-card">';
        echo '<img style="max-height: 150px; max-width: 100%;" src="data:image;base64,' . base64_encode($row["item_image"]) . '" alt="Card image cap">';
        echo '</div>';

        echo '    <div class="card-body">';
        echo '        <h5 class="card-title">Name: ' . $row['item_name'] . ' </h5>';
        echo '        <p class="card-text">Price: &#8369;' . number_format($row['price'], 2) . '</p>';
        echo '        <p class="card-text">Renting Fee: &#8369;' . number_format($row['renting_fee'], 2) . '</p>';

        echo '<div class="row cus-btn-group">';

        echo '        <p class="card-text" style="padding-left: 5%;">Stock: ' . $row['stock'] . '</p>';

        echo '    <div class="float-right cus-btn-group">';
        echo '        <a class="btn btn-primary cus-btn-i"  href="php/edit_item.php?item_id=' . $row['item_id'] . '">Edit</a>';
        echo '        <a class="btn btn-danger cus-btn-i"  href="php/delete_item.php?item_id=' . $row['item_id'] . '">Delete</a>';
        echo '    </div>';
        echo '</div>';

        echo '    </div>';
        echo '</div>';
    }
}
$con_db->close();
