var express = require('express'),
    session = require('express-session'),
    bodyParser = require('body-parser'),
    sha1 = require('sha1'),
    mysql = require('mysql'),
    url = require('url');

var app = express();


var connection = mysql.createConnection({
    host     : 'database',
    user     : 'root',
    password : 'test',
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

app.listen(80, '0.0.0.0');

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
            throw err;
            request.session.email = result[0].email;
            request.session.password = result[0].password;
        }
        connection.query(sql1, function (err, result, field) {
            if(err){
                throw err;
            }
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
            contact: contact
        });
    }
});

app.get('/edit_profile', function (request, response) {
    if(request.session.username){
            var username = request.session.username,
            first_name = request.session.first_name,
            last_name = request.session.last_name,
            birthdate = request.session.birthdate,
            email = request.session.email,
            address = request.session.address,
            contact = request.session.contact,
            password = request.session.password;    
        response.render('edit_profile', {
            username: username,
            first_name: first_name,
            last_name: last_name,
            birthdate: birthdate,
            email: email,
            address: address,
            contact: contact,
            password: password
        });
    }
});

app.get('/logout', function (request, response) {
    if(request.session.username){
        request.session.destroy();
        response.redirect('http://www.tenterent.com');
    }
});

app.get('/item', function (req, res) {
    'use strict';
    var counter = 'SELECT COUNT(item_id) as count FROM items NATURAL JOIN item_type NATURAL JOIN service_provider';
    
    connection.query(counter, function(err, result, field){
            if(err){
                throw err;
            }
                var sql = 'SELECT item_name, price, renting_fee, stock, type_name, provider_name, provider_contact, provider_address, item_image FROM items natural join item_type natural join service_provider';
                connection.query(sql, function (err1, result1, field1) {
                if (err1) {
                    throw err1;
                }
                var image = [];
                var item_name = [];
                var price = [];
                var renting_fee = [];
                var provider = [];
                var provider_contact = [];
                var stock = [];
                Object.keys(result1).forEach(function (key) {
                    var row = result1[key];
                    var buffer = new Buffer(row.item_image,'binary');
                    var im = buffer.toString('base64');
                    image.push(im);
                    item_name.push(row.item_name);
                    price.push(row.price);
                    renting_fee.push(row.renting_fee);
                    provider.push(row.provider_name);
                    provider_contact.push(row.provider_contact);
                    stock.push(row.stock);
                });
                if(req.session.username){
                    var username = req.session.username
                    res.render('rental', {
                        username: username,
                        image : image,
                        item_name: item_name,
                        price: price,
                        renting_fee: renting_fee,
                        provider: provider,
                        provider_contact: provider_contact,
                        stock : stock
                });
                }
            });
    }); 
});

app.post('/rent', function(req, res) {
    var provider = req.body.provider;
    var item_name = req.body.item_name;
    var username = req.session.username;
    var rent_days = parseInt(req.body.days);
    var quantity = parseInt(req.body.quantity);
    var amount = parseInt(req.body.amount);
    var sql = "Select customer_id from customer natural join accounts where username = '" + username + "';";
    var sql3 = "Select item_id, provider_id from items natural join service_provider where item_name = '" + item_name + "' and provider_name = '" + provider + "';";
    var datetime = new Date();
    var year =datetime.getFullYear();
    var month =datetime.getMonth() + 1;
    var day = datetime.getDate();
    var rent_day = year+ "-"+month+"-"+day;
    var reply = "echo <script> alert('Thank you for renting'); window.history.back(); </script>";
    var total_amount = amount * quantity * rent_days;
    var due_days = day + rent_days;
    var due_date = year+"-"+month+"-"+due_days;
    connection.query(sql, function(err, result, field) {
       if(err){
           throw err;
       }
        connection.query(sql3, function(err, result1, field1) {
           if(err){
               throw err;
           }
            var sql2 = "INSERT INTO transaction (item_id, date_rented, date_due, quantity,amount, approved, returned, customer_id) VALUES ('" + result1[0].item_id + "','" + rent_day + "','" + due_date + "','" + quantity + "','" + total_amount + "','p','0','" + result[0].customer_id + "')";
            connection.query(sql2, function(err, result2, field2){
                if(err){
                    throw err;
                }
            })
        });
    });
    res.send(reply);
});

