var express = require('express')
,   session = require('express-session')
,   bodyParser = require('body-parser')
,	mysql = require('mysql');

var app = express();


var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    database : 'tenterent'
});
connection.connect(function(err){
    if(!err) {
        console.log("Database is connected");
    } else {
        console.log("Error while connecting with database");
    }
});

app.listen(8091,'localhost');

app.use(express.static('public'));
app.set('views', `${__dirname}/view`);
app.set('view engine', 'pug');

app.get('/', function (req, res) {
	res.render('example');
});
