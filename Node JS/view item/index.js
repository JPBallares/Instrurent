var express = require('express'),
    bodyParser = require('body-parser'),
    mysql = require('mysql');

var app = express();
var urlencodedParser = bodyParser.urlencoded({ extended: true });

var connection = mysql.createConnection({
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: '',
    database: 'tenterent'
    
});
 
// Running Server Details.
var server = app.listen(8081, function () {
    'use strict';
    var host = server.address().address,
        port = server.address().port;
    console.log("Example app listening at %s:%s Port", host, port);
});

app.post('/item', urlencodedParser, function (req, res) {
    'use strict';
    var html = '';
	var counter = 'SELECT COUNT(item_id) as count FROM items NATURAL JOIN item_type NATURAL JOIN service_provider';
	
	connection.query(counter, function(err, result, field){
			if(err){
				throw err;
			}
			//for (var x = 1; x <= result[0].count; x++){
				var sql = 'SELECT item_name, price, renting_fee, stock, type_name, provider_name, provider_contact, provider_address, item_image FROM items natural join item_type natural join service_provider where item_id = ' + result[0].count;
				connection.query(sql, function (err1, result1, field1) {
				if (err1) {
					throw err1;
				}

				Object.keys(result1).forEach(function (key) {
					var row = result1[key];
					var buffer = new Buffer(row.item_image,'binary');
					var image = buffer.toString('base64');
					html += "<body>";
					html += row.item_name + "<br>" + row.price + "<br>" + row.renting_fee + "<br> " + row.stock + "<br> " + row.type_name + "<br>" + row.provider_name + "<br>" + row.provider_contact + "<br>" + row.provider_address + " <br>";
					html += `<img src="data:image;base64,` + image +`">`;
					html += "</body>";
					res.write(html);
					res.run;

				});
			});
				console.log(x);
			//}

		
			
	});	
});