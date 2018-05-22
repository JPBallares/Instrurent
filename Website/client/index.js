var express = require('express'),
    session = require('express-session'),
    bodyParser = require('body-parser'),
    sha1 = require('sha1'),
    mysql = require('mysql'),
    url = require('url');

var app = express();


var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : '',
    port     : 3306,
    database : 'tenterent'
});
connection.connect(function (err) {
    if (!err) {
        console.log("Database is connected");
    } else {
        console.log("Error while connecting with database");
    }
});

app.listen(8081, '0.0.0.0');

app.use(express.static('public'));
app.use(session({ secret: 'somesecretkey', resave: false, saveUninitialized: false }));
app.set('views', './view');
app.set('view engine', 'pug');
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', function (req, res) {
	if(req.session.username){
        var username = req.session.username
        res.render('index', {username: username});
    }
	
});

app.get('/rental', function (req, res) {
	if(req.session.username){
        var username = req.session.username
        res.render('rental', {username: username});
    }
});

app.get('/aboutus', function (req, res) {
	if(req.session.username){
        var username = req.session.username
        res.render('aboutus', {username: username});
    }
});

app.get('/contact', function (req, res) {
	if(req.session.username){
        var username = req.session.username
        res.render('contact', {username: username});
    }
});

app.post('/login', function (request, response) {
    'use strict';
    var username = request.body.username,
        password = sha1(request.body.password),
        sql = "Select * from accounts natural join customer where username = '" + username + "';",
        reply1 = "<script> alert('Username does not exist'); window.history.back(); </script>",
        reply2 = "<script> alert('Wrong password'); window.history.back(); </script>",
        reply3 = "<script> alert('You are now logged in'); window.history.back(); </script>";
    connection.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        if (result.length === 1) {
            if (result[0].password === password) {
                request.session.loggedin = true;
                request.session.username = username;
                request.session.email = result[0].email;
                request.session.password = password;
                request.session.first_name = result[0].first_name;
                request.session.last_name = result[0].last_name;
                request.session.address = result[0].address;
                request.session.birthdate = result[0].birthdate;
                request.session.contact = result[0].contact_number;
                response.redirect('/');
            } else {
                response.send(reply2);
            }

        } else {
            response.send(reply1);
        }
    });
});

app.post('/edit_prof', function (request, response) {
    'use strict';
    var first_name = request.body.first_name,
        last_name = request.body.last_name,
        email = request.body.email,
        address = request.body.address,
        password = sha1(request.body.password),
        contact = request.body.contact,
        username = request.session.username,
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>",
        sql = "UPDATE accounts SET email = '" + email + "', password = '" + password + "' WHERE username = '" + username + "';",
        sql1 = "UPDATE customer NATURAL JOIN accounts SET first_name = '" + first_name + "', last_name = '" + last_name + "', address = '" + address + "', contact_number = '" + contact + "' WHERE username = '" + username +"';";
    connection.query(sql, function (err, result, field) {
        if(err){
            console.log(err);
            request.session.email = result[0].email;
            request.session.password = result[0].password;
        }
        connection.query(sql1, function (err, result, field) {
            if(err){
                console.log(err);
            }
            request.session.first_name = result[0].first_name;
            request.session.last_name = result[0].last_name;
            request.session.address = result[0].address;
            request.session.birthdate = result[0].birthdate;
            request.session.contact = result[0].contact_number;
        });
    });
    response.send(reply);
});

app.get('/view_profile', function (request, response) {
    	if(request.session.username){
            var username = request.session.username,
                first_name = request.session.first_name,
                last_name = request.session.last_name,
                birthdate = request.session.birthdate,
                email = request.session.email,
                address = request.session.address,
                contact = request.session.contact;
        response.render('view_profile', {
            username: username,
            first_name: first_name,
            last_name: last_name,
            birthdate: birthdate,
            email: email,
            address: address,
            contact: contact,
        });
    }
});

app.get('/edit_profile', function (request, response) {
    	if(request.session.username){
        response.render('edit_profile', {
            username: request.session.username,
        });
    }
});

app.get('/logout', function (request, response) {
    if(request.session.username){
        request.session.destroy();
        response.redirect('www.tenterent.com');
    }
});