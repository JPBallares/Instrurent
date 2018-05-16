var express = require('express'),
    bodyParser = require('body-parser'),
    mysql = require('mysql'),
    sha1 = require('sha1'),
    session = require('express-session');

var app = express();

var urlencodedParser = bodyParser.urlencoded({ extended: true });
app.use(session({
    secret: 'secretsecret',
    resave: 'false',
    saveUninitialized: 'false'
}));

var server = app.listen(8091, function () {
    'use strict';
    var host = server.address().address,
        port = server.address().port;
    console.log("Example app listening at %s:%s Port", host, port);
});

var db = mysql.createConnection({
    host: 'localhost',
    port: 3308,
    user: 'root',
    password: '',
    database: 'tenterent'
});

app.use(session({
    secret: 'secretsecret',
    resave: false,
    saveUninitialized: true
}));

//print user info


//username
app.post('/updateUsername', urlencodedParser, function (request, response) {
    'use strict';
    var user = request.session.username;
    var username = request.body.username,
        sql = "Update accounts SET username = '" + username + "' where account_id = '1';",
        reply1 = "<script> alert('Updated Username'); window.history.back(); </script>";
    db.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        response.send(reply1);
    });
});

//password
app.post('/updatePassword', urlencodedParser, function (request, response) {
    'use strict';
    var user = request.session.username;
    var password = request.body.password,
        sql = "Update accounts SET password = '" + password + "' where account_id = '1';",
        reply1 = "<script> alert('Updated Password'); window.history.back(); </script>";
    db.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        response.send(reply1);
    });
});

//email
app.post('/updateEmail', urlencodedParser, function (request, response) {
    'use strict';
    var user = request.session.username;
    var email = request.body.email,
        sql = "Update accounts SET email = '" + email + "' where account_id = '1';",
        reply1 = "<script> alert('Updated Email'); window.history.back(); </script>";
    db.query(sql, function (err, result, field) {
        if (err) {
            throw err;
        }
        response.send(reply1);
    });
});