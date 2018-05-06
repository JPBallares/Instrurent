const express = require('express')
,     session = require('express-session')
,     mysql   = require('mysql')
,     bodyParser = require('body-parser');


const app = express();
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
global.db = connection;

app.use(express.static('public'));
app.set('views', `./view`);
app.set('view engine', 'pug');
app.use(bodyParser.urlencoded({extended: true}));


app.listen(8080, 'localhost');

app.post('/loginform',function (request, response){
    let username = request.body.username;
	let password = request.body.password;
	connection.query('SELECT * FROM accounts WHERE username =?', [username], function (error, results, fields){
		if (error) {
			response.json({
				status: false,
				message:'there is something wrong.'
			})
		} else {
			if (results.length > 0) {
				if (password == results[0].password){
					response.json({
						status: true,
						message: 'WELCOME'
					})
				}else{
					response.json({
						status: false,
						message: 'Username and password does not match'
					})
				}
			}	
		}	
	});
	
});