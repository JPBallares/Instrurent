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
    port: 3306,
    user: 'root',
    password: '',
    database: 'tenterent'
});

/**app.use(session({
    secret: 'secretsecret',
    resave: false,
    saveUninitialized: true
}));**/

app.post('/login', urlencodedParser, function (request, response) {
    'use strict';
    var user = request.session.username;
    var username = request.body.username,
        password = request.body.password,
        sql = "Select * from accounts where username = '" + username + "';",
        reply1 = "<script> alert('No username exist'); window.history.back(); </script>",
        reply2 = "<script> alert('Wrong password'); window.history.back(); </script>",
        reply3 = "<script> alert('You are now logged in'); window.history.back(); </script>";
    db.query(sql, function (err, result, field) {
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
    console.log(user);
});
