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
    'use strict';
    if (!err) {
        console.log("Database is connected");
    } else {
        console.log("Error while connecting with database");
    }
});

app.listen(8081, '0.0.0.0');

app.use(express.static('public'));
app.use(session({ secret: 'somesecretcode', resave: false, saveUninitialized: false }));
app.set('views', './view');
app.set('view engine', 'pug');
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', function (request, response) {
	'use strict';
    if (request.session.username) {
        var username = request.session.username;
        response.render('index', {username: username});
    }
	
});

app.get('/aboutus', function (request, response) {
    'use strict';
	if (request.session.username) {
        var username = request.session.username;
        response.render('aboutus', {username: username});
    }
});

app.get('/contact', function (request, response) {
    'use strict';
	if (request.session.username) {
        var username = request.session.username;
        response.render('contact', {username: username});
    }
});

app.post('/login', function (request, response) {
    'use strict';
    var username = request.body.username,
        password = sha1(request.body.password),
        sql = "SELECT * FROM accounts NATURAl JOIN customer where username = '" + username + "';",
        reply1 = "<script> alert('Username does not exist'); window.history.back(); </script>",
        reply2 = "<script> alert('Wrong password'); window.history.back(); </script>",
        reply3 = "<script> alert('You are now logged in'); window.history.back(); </script>";
    connection.query(sql, function (err, result, field) {
        if (err) {
            console.log(err);
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

app.post('/edit_profile', function (request, response) {
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
        sql1 = "UPDATE customer NATURAL JOIN accounts SET first_name = '" + first_name + "', last_name = '" + last_name + "', address = '" + address + "', contact_number = '" + contact + "' WHERE username = '" + username + "';";
    connection.query(sql, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        connection.query(sql1, function (err, result, field) {
            if (err) {
                console.log(err);
            }
        });
    });
    response.send(reply);
});

app.get('/view_profile', function (request, response) {
    'use strict';
    if (request.session.username) {
        var username = request.session.username,
            first_name = "",
            last_name = "",
            birthdate = "",
            email = "",
            address = "",
            contact = "",
            sql = "SELECT * FROM accounts NATURAL JOIN customer WHERE username = '" + username + "';";
        connection.query(sql, function (err, result, field) {
            first_name += result[0].first_name;
            last_name += result[0].last_name;
            birthdate += result[0].birthdate;
            email += result[0].email;
            address += result[0].address;
            contact = result[0].contact_number;
        });
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

app.get('/logout', function (request, response) {
    'use strict';
    if (request.session.username) {
        request.session.destroy();
        response.redirect('http://www.tenterent.com');
    }
});

app.get('/rental', function (request, response) {
    'use strict';
    var sql = "SELECT * FROM items NATURAL JOIN item_type NATURAL join service_provider",
        image = [],
        item_name = [],
        renting_fee = [],
        provider = [],
        provider_contact = [],
        item_type = [],
        stock = [];
    connection.query(sql, function (err1, result, field1) {
        if (err1) {
            throw err1;
        }
        Object.keys(result).forEach(function (key) {
            var row = result[key],
                buffer = new Buffer(row.item_image, 'binary'),
                imahe = buffer.toString('base64');
            image.push(imahe);
            item_name.push(row.item_name);
            renting_fee.push(row.renting_fee);
            stock.push(row.stock);
            provider.push(row.provider_name);
            provider_contact.push(row.provider_contact);
            item_type.push(row.type_name);
        });
        if (request.session.username) {
            var username = request.session.username;
            response.render('rental', {
                username: username,
                image : image,
                item_name: item_name,
                renting_fee: renting_fee,
                provider: provider,
                provider_contact: provider_contact,
                stock : stock,
                item_type: item_type
            });
        }
    });
});

app.post('/rent', function (req, res) {
    'use strict';
    var provider = req.body.provider,
        item_name = req.body.item_name,
        username = req.session.username,
        temp_date = req.body.rent_date,
        datetime = new Date(temp_date),
        year = datetime.getFullYear(),
        month = datetime.getMonth() + 1,
        day = datetime.getDate(),
        rent_days = parseInt(req.body.days, 10),
        quantity = parseInt(req.body.quantity, 10),
        amount = parseInt(req.body.amount, 10),
        rent_day = year + "-" + month + "-" + day,
        total_amount = amount * quantity * rent_days,
        due_days = day + rent_days,
        due_date = year + "-" + month + "-" + due_days,
        user_id = "Select customer_id from customer natural join accounts where username = '" + username + "';",
        item = "Select item_id, provider_id from items natural join service_provider where item_name = '" + item_name + "' and provider_name = '" + provider + "';",
        reply = "echo <script> alert('Thank you for renting'); window.history.back(); </script>",
        reply1 = "echo <script> alert('Not enough stock'); window.history.back(); </script>";
    connection.query(user_id, function (err, result, field) {
        if (err) {
            throw err;
        }
        connection.query(item, function (err, result1, field1) {
            if (err) {
                throw err;
            }
            var stock = parseInt(result1[0].stock, 10);
            if (quantity > stock) {
                res.send(reply1);
            } else {
                var sql = "INSERT INTO transaction (item_id, date_rented, date_due, quantity,amount, approved, returned, customer_id) VALUES ('" + result1[0].item_id + "','" + rent_day + "','" + due_date + "','" + quantity + "','" + total_amount + "','p','0','" + result[0].customer_id + "')";
                connection.query(sql, function (err, result2, field2) {
                    if (err) {
                        console.log(err);
                    }
                    res.send(reply);
                });
            }
        });
    });
});

app.get('/transaction', function (request, response) {
    'use strict';
    var username = request.session.username,
        id = "SELECT * FROM cutomer NATURAL JOIN accounts where username = '" + username + "';",
        transaction_id = [],
        item_name = [],
        item_type = [],
        date_rented = [],
        date_due = [],
        amount = [],
        quantity = [],
        approved = [],
        returned = [],
        provider_name = [];
    connection.query(id, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        var sql = "SELECT * FROM transaction NATURAL JOIN items NATURAL JOIN service_provider NATURAL JOIN item_type where customer_id = '" + result[0].customer_id;
        connection.query(sql, function (err1, result1, field1) {
            Object.keys(result1).forEach(function (key) {
                var row = result1[key];
                transaction_id.push(row.transaction_id);
                item_name.push(row.item_name);
                item_type.push(row.item_type);
                date_rented.push(row.date_rented);
                date_due.push(row.date_due);
                amount.push(row.amount);
                quantity.push(row.quantity);
                if (row.approved === "p") {
                    approved.push("Pending");
                } else if (row.approved === "r") {
                    approved.push("Rejected");
                } else {
                    approved.push("Cancelled");
                }
                if (row.retuned === "0") {
                    returned.push("Not yet returned ");
                } else {
                    returned.push("Returned");
                }
                provider_name.push(row.provider_name);
            });
            if (request.session.username) {
                response.render('transaction', {
                    username: username,
                    transac_id: transaction_id,
                    item_name: item_name,
                    item_type: item_type,
                    date_rented: date_rented,
                    date_due: date_due,
                    amount: amount,
                    quantity: quantity,
                    approved: approved,
                    returned: returned,
                    provider: provider_name
                });
            }
        });
    });
});
        




