var mysql = require('mysql');

var con = mysql.createConnection(
    {
        host: "localhost",
        user: "root",
        password: "",
        database: "tenterent"
    }
);

con.connect(function (err) {
    if (err) {
        throw err;
    }
  //Select only "name" and "address" from "customers":
    con.query("SELECT item_name, price, renting_fee, stock, item_image, provider_name, type_name FROM items join service_provider using (provider_id) join item_type using(type_id)", function (err, result, fields) {
        if (err) {
            throw err;
        }
        console.log(result);
    }
        );
});