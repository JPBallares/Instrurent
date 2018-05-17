var express = require('express')
,   session = require('express-session')
,   bodyParser = require('body-parser')
,   sha1 = require('sha1')
,	mysql = require('mysql');

var app = express();


var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    port     : 3306,
    database : 'tenterent'
});
connection.connect(function(err){
    if(!err) {
        console.log("Database is connected");
    } else {
        console.log("Error while connecting with database");
    }
});

app.listen(8081,'localhost');

app.use(express.static('public'));

app.set('views', './view');
app.set('view engine', 'pug');
app.use(bodyParser.urlencoded({ extended: true }));
app.get('/',(req, res) => {
	res.render('index');
});

app.get('/rental', (req, res) => {
	res.render('index');
});

app.get('/aboutus', (req, res) => {
	res.render('aboutus');
});

app.get('/contact', (req, res) => {
	res.render('contact');
});

app.post('/login', function (request, response) {
    'use strict';
    var username = request.body.username,
        password = request.body.password,
        sql = "Select * from accounts where username = '" + username + "';",
        reply1 = "<script> alert('Username does not exist'); window.history.back(); </script>",
        reply2 = "<script> alert('Wrong password'); window.history.back(); </script>",
        reply3 = "<script> alert('You are now logged in'); window.history.back(); </script>";
    connection.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        if (result.length === 1) {
            if (result[0].password === password) {
                response.send(reply3);
                request.session.username = username;
                console.log(request.session.username);
            } else {
                response.send(reply2);
            }

        } else {
            response.send(reply1);
        }
    });
});
