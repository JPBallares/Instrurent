var express = require('express'),
    bodyParser = require('body-parser'),
    mysql = require('mysql');

var app = express();
var urlencodedParser = bodyParser.urlencoded({ extended: true });

var connection = mysql.createConnection({
    host: 'localhost',
    port: 3308,
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
    var item_id = "'" + req.body.id + "'",
        html = '',
        sql = 'SELECT item_name, price, renting_fee, stock, type_name, provider_name, provider_contact, provider_address FROM items natural join item_type natural join service_provider where item_id = ' + item_id;
    connection.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            html += row.item_name + "<br>" + row.price + "<br>" + row.renting_fee + "<br> " + row.stock + "<br> " + row.type_name + "<br>" + row.provider_name + "<br>" + row.provider_contact + "<br>" + row.provider_address;
            res.send(html);
        });
    });
});