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

app.listen(8081, 'localhost');

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
                request.session.username = username;
                response.redirect('/');
            } else {
                response.send(reply2);
            }

        } else {
            response.send(reply1);
        }
    });
});

//profile
app.get('/view_profile', function (request, response) {
    'use strict';
    if (request.session.username) {
        var username = request.session.username,
            sql = "SELECT * FROM accounts NATURAL JOIN customer WHERE username = '" + username + "';";
        connection.query(sql, function (err, result, field) {
            var first_name = result[0].first_name,
                last_name = result[0].last_name,
                temp = new Date(result[0].birthdate),
                birthdate = temp.getFullYear() + "-" + temp.getMonth() + "-" + temp.getDate(),
                email = result[0].email,
                address = result[0].address,
                contact = result[0].contact_number;
            response.render('view_profile', {
                username: username,
                first_name: first_name,
                last_name: last_name,
                birthdate: birthdate,
                email: email,
                address: address,
                contact: contact
            });
        });
    }
});

app.post('/edit_profile', function (request, response) {
    'use strict';
    var first_name = request.body.first_name,
        last_name = request.body.last_name,
        email = request.body.email,
        address = request.body.address,
        contact = request.body.contact,
        username = request.session.username,
        sql = "UPDATE accounts SET email = '" + email + "' WHERE username = '" + username + "';",
        sql1 = "UPDATE customer NATURAL JOIN accounts SET first_name = '" + first_name + "', last_name = '" + last_name + "', address = '" + address + "', contact_number = '" + contact + "' WHERE username = '" + username + "';",
        sql2 = "SELECT * FROM accounts NATURAL JOIN customer where useername = '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>",
        reply1 = "echo <script> alert('Email already exists'); window.history.back(); </script>",
        reply2 = "echo <script> alert('Contact number already exists'); window.history.back(); </script>";
    connection.query(sql2, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        if (email === result[0].email) {
            response.send(reply1);
        } else if (contact === result[0].contact_number) {
            response.send(reply2);
        } else {
            connection.query(sql, function (err, result, field) {
                if (err) {
                    console.log(err);
                }
            });
            connection.query(sql1, function (err, result, field) {
                if (err) {
                    console.log(err);
                }
            });
            response.send(reply);
        }
    });
});

app.post('/edit_first', function (request, response) {
   'use strict';
    var username = request.session.username,
        first_name = request.body.first_name,
        sql = "UPDATE customer NATURAL JOIN accounts SET first_name = '" + first_name + "' WHERE username = '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>";
    connection.query(sql, function (err, result) {
       if (err) {
           throw err;
       }
        response.send(reply);
    });
});

app.post('/edit_last', function (request, response) {
   'use strict';
    var username = request.session.username,
        last_name = request.body.last_name,
        sql = "UPDATE customer NATURAL JOIN accounts SET last_name = '" + last_name + "' WHERE username = '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>";
    connection.query(sql, function (err, result) {
       if (err) {
           throw err;
       }
        response.send(reply);
    });
});

app.post('/edit_address', function (request, response) {
   'use strict';
    var username = request.session.username,
        address = request.body.address,
        sql = "UPDATE customer NATURAL JOIN accounts SET address = '" + address + "' WHERE username = '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>";
    connection.query(sql, function (err, result) {
       if (err) {
           throw err;
       }
        response.send(reply);
    });
});


app.post('/edit_email', function (request, response) {
   'use strict';
    var username = request.session.username,
        email = request.body.email,
        sql = "UPDATE accounts SET email = '" + email + "' WHERE username = '" + username + "';",
        checker = "Select email From accounts where username <> '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>",
        check = "",
        reply1 = "echo <script> alert('Email already exists'); window.history.back(); </script>";
    connection.query(checker, function (err, result) {
       if (err) {
           throw err;
       }
        Object.keys(result).forEach(function (key) {
            var row = result[key];
                if (row.email === email){
                    check += "1";
                } else {
                    check += "0";
                }
        });
        if (check.includes("1")) {
            response.send(reply1);
        } else {
            connection.query(sql, function (err, result) {
               if (err) {
                   throw err;
               }
                response.send(reply);
            });
        }
    });
});

app.post('/edit_contact', function (request, response) {
   'use strict';
    var username = request.session.username,
        contact = request.body.contact,
        sql = "UPDATE customer NATURAL JOIN accounts SET contact_number = '" + contact + "' WHERE username = '" + username + "';",
        checker = "Select contact_number From customer NATURAL JOIN accounts where username <> '" + username + "';",
        reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>",
        check = "",
        reply1 = "echo <script> alert('Contact Number already exists'); window.history.back(); </script>";
    connection.query(checker, function (err, result) {
       if (err) {
           throw err;
       }
        Object.keys(result).forEach(function (key) {
            var row = result[key];
                if (row.contact_number === contact){
                    check += "1";
                } else {
                    check += "0";
                }
        });
        if (check.includes("1")) {
            response.send(reply1);
        } else {
            connection.query(sql, function (err, result) {
               if (err) {
                   throw err;
               }
                response.send(reply);
            });
        }
    });
});


app.post('/edit_password', function (request, response) {
   var current = sha1(request.body.oldpass),
       pass1 = request.body.newpass,
       pass2 = request.body.conpass,
       username = request.session.username,
       sql = "SELECT password FROM accounts where username = '" + username + "';",
       reply = "echo <script> alert('Successfully updated'); window.history.back(); </script>",
       reply1 = "echo <script> alert('Wrong password'); window.history.back(); </script>",
       reply2 = "echo <script> alert('Password does not match'); window.history.back(); </script>";
    if (pass1 === pass2) {
        connection.query (sql, function (err, result) {
            if (err) {
                throw err;
            }
            if (current === result[0].password){
                var password = sha1(pass1),
                    sql1 = "UPDATE accounts SET password = '" + password + "';";
                connection.query(sql1, function (err1, result1) {
                    if (err1) {
                        throw err1;
                    }
                    response.send(reply);
                });
            } else {
                response.send(reply1);
            }
        });
    } else {
        response.send(reply2);
    }
});
//profile

//rental
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

app.post('/type', function (request, response) {
    'use strict';
    var type_name = request.body.type_name,
        sql = "SELECT * FROM items NATURAL JOIN item_type NATURAL join service_provider where type_name = '" + type_name + "';",
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

app.post('/sort_price', function (request, response) {
    'use strict';
    var order = request.body.order,
        sql = "SELECT * FROM items NATURAL JOIN item_type NATURAL join service_provider ORDER BY price " + order + ";",
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
//rental

//transaction
app.get('/transaction', function (request, response) {
    'use strict';
    var username = request.session.username,
        id = "SELECT * FROM customer NATURAL JOIN accounts where username = '" + username + "';",
        transaction_id = [],
        item_name = [],
        item_type = [],
        date_rented = [],
        date_due = [],
        amount = [],
        quantity = [],
        approved = [],
        returned = [],
        date_returned = [],
        item_id = [],
        provider_name = [];
    connection.query(id, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        var sql = "SELECT * FROM transaction NATURAL JOIN items NATURAL JOIN service_provider where customer_id = '" + result[0].customer_id + "';";
        connection.query(sql, function (err1, result1, field1) {
            Object.keys(result1).forEach(function (key) {
                var row = result1[key];
                transaction_id.push(row.transaction_id);
                item_name.push(row.item_name);
                item_id.push(row.item_id);
                date_rented.push(row.date_rented);
                date_due.push(row.date_due);
                date_returned.push(row.date_returned);
                amount.push(row.amount);
                quantity.push(row.quantity);
                if (row.approved === "p") {
                    approved.push("Pending");
                } else if (row.approved === "r") {
                    approved.push("Rejected");
                } else if (row.approved === "c") {
                    approved.push("Cancelled");
                } else {
                    approved.push("Accepted");
                }
                returned.push(row.returned);
                provider_name.push(row.provider_name);
            });
            if (request.session.username) {
                response.render('transaction', {
                    username: username,
                    transac_id: transaction_id,
                    item_name: item_name,
                    date_rented: date_rented,
                    date_due: date_due,
                    amount: amount,
                    quantity: quantity,
                    approved: approved,
                    returned: returned,
                    provider: provider_name,
                    date_returned: date_returned,
                    item_id: item_id
                });
            }
        });
    });
});

app.post('/accepted', function (request, response) {
    'use strict';
    var username = request.session.username,
        id = "SELECT * FROM customer NATURAL JOIN accounts where username = '" + username + "';",
        accepted = request.body.accepted,
        transaction_id = [],
        item_name = [],
        item_type = [],
        date_rented = [],
        date_due = [],
        amount = [],
        quantity = [],
        approved = [],
        returned = [],
        date_returned = [],
        item_id = [],
        provider_name = [];
    connection.query(id, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        var sql = "SELECT * FROM transaction NATURAL JOIN items NATURAL JOIN service_provider where customer_id = '" + result[0].customer_id + "' and approved = '" + accepted + "';";
        connection.query(sql, function (err1, result1, field1) {
            Object.keys(result1).forEach(function (key) {
                var row = result1[key];
                transaction_id.push(row.transaction_id);
                item_name.push(row.item_name);
                item_id.push(row.item_id);
                date_rented.push(row.date_rented);
                date_due.push(row.date_due);
                date_returned.push(row.date_returned);
                amount.push(row.amount);
                quantity.push(row.quantity);
                if (row.approved === "p") {
                    approved.push("Pending");
                } else if (row.approved === "r") {
                    approved.push("Rejected");
                } else if (row.approved === "c") {
                    approved.push("Cancelled");
                } else {
                    approved.push("Accepted");
                }
                returned.push(row.returned);
                provider_name.push(row.provider_name);
            });
            if (request.session.username) {
                response.render('transaction', {
                    username: username,
                    transac_id: transaction_id,
                    item_name: item_name,
                    date_rented: date_rented,
                    date_due: date_due,
                    amount: amount,
                    quantity: quantity,
                    approved: approved,
                    returned: returned,
                    provider: provider_name,
                    date_returned: date_returned,
                    item_id: item_id
                });
            }
        });
    });
});

app.post('/returned', function (request, response) {
    'use strict';
    var username = request.session.username,
        id = "SELECT * FROM customer NATURAL JOIN accounts where username = '" + username + "';",
        transaction_id = [],
        item_name = [],
        item_type = [],
        date_rented = [],
        date_due = [],
        amount = [],
        quantity = [],
        approved = [],
        returned = [],
        date_returned = [],
        item_id = [],
        provider_name = [];
    connection.query(id, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        var sql = "SELECT * FROM transaction NATURAL JOIN items NATURAL JOIN service_provider where customer_id = '" + result[0].customer_id + "' and returned = '" + request.body.returned + "';";
        connection.query(sql, function (err1, result1, field1) {
            Object.keys(result1).forEach(function (key) {
                var row = result1[key];
                transaction_id.push(row.transaction_id);
                item_name.push(row.item_name);
                item_id.push(row.item_id);
                date_rented.push(row.date_rented);
                date_due.push(row.date_due);
                date_returned.push(row.date_returned);
                amount.push(row.amount);
                quantity.push(row.quantity);
                if (row.approved === "p") {
                    approved.push("Pending");
                } else if (row.approved === "r") {
                    approved.push("Rejected");
                } else if (row.approved === "c") {
                    approved.push("Cancelled");
                } else {
                    approved.push("Accepted");
                }
                returned.push(row.returned);
                provider_name.push(row.provider_name);
            });
            if (request.session.username) {
                response.render('transaction', {
                    username: username,
                    transac_id: transaction_id,
                    item_name: item_name,
                    date_rented: date_rented,
                    date_due: date_due,
                    amount: amount,
                    quantity: quantity,
                    approved: approved,
                    returned: returned,
                    provider: provider_name,
                    date_returned: date_returned,
                    item_id: item_id
                });
            }
        });
    });
});
        
app.post('/cancel', function (request, response) {
    'use strict';
    var username = request.session.username,
        transac_id = request.body.transac_id,
        item_id = request.body.item_id,
        reply = "echo <script> alert('You have canceled a transaction'); window.location = '/transaction'; </script>";
    var sql = "UPDATE transaction SET approved = 'c' WHERE transaction_id = '" + transac_id + "' and item_id = '" + item_id + "';";
    connection.query(sql, function (err, result, field) {
        if (err) {
            console.log(err);
        }
        response.send(reply);
    });
});
//transaction

app.get('/logout', function (request, response) {
    'use strict';
    if (request.session.username) {
        request.session.destroy();
        response.redirect('http://www.tenterent.com');
    }
});



