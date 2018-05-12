<?php
	$con_db = new mysqli("localhost", "root", "", "tenterent");
	$sql = "select item_name, price, renting_fee, stock, item_image from items";
	$res = $con_db->query($sql);
    $counter = 0;

	if($res->num_rows > 0) {
		while($row = $res->fetch_assoc()) {
            echo '<div class="card cus-card" style="width: 300px; height: 350px;">';
            echo '<img style="width: 300px; height: 150px;" src="data:image;base64,' . base64_encode($row["item_image"]) . '" alt="Card image cap">';
            echo '    <div class="card-body">';
            echo '        <h5 class="card-title">Name</h5>';
            echo '        <p class="card-text">Price: </p>';
            echo '        <p class="card-text">Renting Fee: </p>';
            echo '        <p class="card-text">Stock: </p>';
            echo '    </div>';
            echo '</div>';
		}
	}
	$con_db->close();
?>
