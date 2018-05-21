var express = require('express')
,   session = require('express-session')
,   bodyParser = require('body-parser')
,   sha1 = require('sha1')
,	mysql = require('mysql')
,	url = require('url');

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

app.listen(8091,'localhost');

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

app.post('/signup', function (request, response){
	'use strict'
	var firstname = request.body.client_first_name
	,	lastname = request.body.client_last_name
	,	gender = request.body.gender
	,	birthdate = request.body.birth_date
	,	username = request.body.client_username
	,	email = request.body.client_email
	,	address = request.body.client_address
	,	password = request.body.client_password
	,	contact = request.body.client_contact
	,	type = 'c';	
	var input = "INSERT INTO `accounts` (`account_id`, `email`, `username`, `password`, `account_type`) VALUES (NULL, "+email+", "+ username+ ", "+ password+", "+type+");",
		input1 = "INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `address`, `birthdate`, `contact_number`, `accepted`, `account_id`) VALUES (NULL, "+first_name+", "+last_name+", "+address+", "+birthdate+", "+contact+", 'p', 'accountid');",
		sql = "Select * from accounts where username = '" + username + "';",
		sql1 = "Select * from accounts where email = '" + email + "';",
        reply1 = "<script> alert('Email address that you have entered is already in use'); window.history.back(); </script>",
        reply2 = "<script> alert('Username that you have entered is already taken'); window.history.back(); </script>",
        reply3 = "<script> alert('Password length must be greater than 8 and less than 20 characters'); window.history.back(); </script>",
		reply4 =  "<script> alert('Invalid Contact Number'); window.history.back(); </script>",
		reply5 =  "<script> alert('Invalid Email'); window.history.back(); </script>",
		success =  "<script> alert('You are now registered.'); window.history.replace('/'); </script>",
		regex = "/^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[A-Za-z]{2,}$/",
		regex1 = "/^09[0-9]{9}$/";
	connection.query(sql, function (err, result, field){
		if (err){
			throw err;
		}
		if (password.length() <8 || password.length() > 20){
			response.send(reply3);
		} else if (!email.match(regex)){
				res.send(reply5);
		} else if (!contact.match(regex1)){
				res.send(reply4);
		}else if (email.match(regex1)){
				res.send(reply4);
		} else{
			response.send(success);
		}
	});
	connection.query(input1)
		
});
