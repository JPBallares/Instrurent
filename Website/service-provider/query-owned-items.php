<?php
	$con_db = new mysqli("localhost", "root", "", "tenterent");
	$sql = "select * from items";
	$res = $con_db->query($sql);

	if($res->num_rows > 0) {
		while($row = $res->fetch_assoc()) {
            echo '<div class="card cus-card" style="width: 300px; height: 350px;">';
            echo '<img style="width: 300px; height: 150px;" src="data:image;base64,' . base64_encode($row["item_image"]) . '" alt="Card image cap">';
            echo '    <div class="card-body">';
            echo '        <h5 class="card-title">Name: ' . $row['item_name'] .' </h5>';
            echo '        <p class="card-text">Price: &#8369;' . $row['price'] . '</p>';
            echo '        <p class="card-text">Renting Fee: &#8369;' . $row['renting_fee'] . '</p>';
            echo '        <p class="card-text">Stock: ' . $row['stock'] . '</p>';
            echo '        <a class="btn btn-danger"  href="php/edit_item.php?item_id='. $row['item_id'] . '">Edit Item</a>';
            echo '        <a class="btn btn-danger"  href="php/delete_item.php?item_id='. $row['item_id'] . '">Delete Item</a>';
            echo '    </div>';
           
            echo '</div>';
		}
	}
	$con_db->close();
?>
