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
    console.log("Successfully connected");
});
var http = require("http");
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var urlencodedParser = bodyParser.urlencoded({ extended: true });
var server = app.listen(8081, function () {
    var host = server.address().address;
    var port = server.address().port;
    console.log("Example app listening at %s:%s Port", host, port);
});
 
 
app.get('/form', function (req, res) {
    var html = '';
    html += "<body>";
    html += "<form action='/thank'  method='post' name='form1'>";
    html += "First Name:</p><input type= 'text' name='fname'><br>";
    html += "Last Name:</p><input type= 'text' name='lname'><br>";
    html += "Address:</p><input type='text' name='address'><br>";
    html += "Mobile number:</p><input type='text' name='mobilno'><br>";
    html += "Email:</p><input type='text' name='email'><br>";
    html += "Username:</p><input type= 'text' name='username'><br>";
    html += "Password:</p><input type= 'password' name='password'><br>";
    html += "<input type='submit' value='submit'><br>";
    html += "<INPUT type='reset'  value='reset'><br>";
    html += "</form>";
    html += "</body>";
    res.send(html);
});


app.post('/thank', urlencodedParser, function (req, res) {
    var reply = "registered";
    var first_name = "'" + JSON.stringify(req.body.fname).replace(/\"/g, "") + "',";
    
    var last_name = "'" + JSON.stringify(req.body.lname).replace(/\"/g, "")  + "',";
    
    var address1 = "'" + JSON.stringify(req.body.address).replace(/\"/g, "") + "',";
    
    var contact_number = "'" + JSON.stringify(req.body.mobilno).replace(/\"/g, "") + "'";
    
    var email = "'" + JSON.stringify(req.body.email).replace(/\"/g, "") + "',";
    
    var username = "'" + JSON.stringify(req.body.username).replace(/\"/g, "") + "',";
    
    var password = "'" + JSON.stringify(req.body.password).replace(/\"/g, "") + "',";
    
    con.connect(function (err) {
       var sql = "INSERT INTO `tenterent`.`accounts` (`email`, `username`, `password`, `account_type`) VALUES (" + email + username + password + "'c');";
        
        var sql2 = "INSERT INTO `tenterent`.`customer` (`first_name`, `last_name`, `address1`, `contact_number`) VALUES (" + first_name + last_name + address1 + contact_number + ");";
        
        con.query(sql, function (err, result) {
            if (err) {
                throw err;
            }
            console.log(result.affectedRows);
        });
        con.query(sql2, function (err, result) {
            if (err) {
                throw err;
            }
            console.log(result.affectedRows);
        });
    });
    res.send(reply);
});
