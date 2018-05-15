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
var server = app.listen(8082, function () {
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
			for (var x = 1; x <= result[0].count; x++){
				var sql = 'SELECT * FROM items NATURAL JOIN item_type NATURAL JOIN service_provider where item_id = ' + x;
				connection.query(sql, function (err, result, field) {
				if (err) {
					throw err;
				}

				Object.keys(result).forEach(function (key) {
					var row = result[key];
					var buffer = new Buffer(row.item_image,'binary');
					var image = buffer.toString('base64');
					html += "<body>";
					html += row.item_name + "<br>" + row.price + "<br>" + row.renting_fee + "<br> " + row.stock + "<br> " + row.type_name + "<br>" + row.provider_name + "<br>" + row.provider_contact + "<br>" + row.provider_address + " <br>";
					html += `<img src="data:image;base64,` + image +`">`;
					html += "</body>";
					res.send(html);
					res.run;

				});
			});
			}

		
			
	});	
});