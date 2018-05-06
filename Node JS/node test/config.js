    var mysql      = require('mysql');
    var connection = mysql.createConnection({
      host     : 'localhost:3306',
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
    module.exports = connection;