<?php
	$con_db = new mysqli("localhost", "root", "", "tenterent");
	$sql = "select item_name, price, renting_fee, stock, item_image from items";
	$res = $con_db->query($sql);
    $counter = 0;

	if($res->num_rows > 0) {
		while($row = $res->fetch_assoc()) {
//			echo "name: " . $row["item_name"] . "<br>price: " . $row["price"] . "<br>renting fee: " . $row["renting_fee"] . "stock: " . $row["stock"];
//            echo '<img src="data:image;base64,' . base64_encode($row["item_image"]) . '"/>';
            
            if($counter == 0) {
                echo "<div class='row cus-row'>";
            }
            
            if($counter++ == 4) {
                echo '<div class="col-sm cus-col-sm">';
                echo '    <img class="sp-item-image" src="data:image;base64,' . base64_encode($row["item_image"]) . '"/>';
				echo '    <div class="sp-item-info">';
				echo '    <p>Name: </p>';
				echo '        <p>Price:'. $row["price"] . '</p>';
				echo '        <p>Renting Fee:' . $row["renting_fee"] . '</p>';
				echo '        <p>Stock:' . $row["stock"] . '</p>';
                echo '        </div>';
                echo '</div>';
            }
		}
	}

    echo "</div>";

	$con_db->close();
?>