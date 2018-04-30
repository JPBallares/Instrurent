var mysql = require('mysql');
var stdin = process.openStdin();

var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "tenterent"
});

con.connect(function (err) {
    if (err) { throw err; }
   //console.log("Connected!");
});

var readline = require('readline');

var rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

rl.question('Please enter the column : ', (answer1) => {
    rl.question('Please the Id number : ', (answer2) => {
        rl.question('Please enter ', (answer3) =>{
            con.connect(function (err) {
                var sql = "UPDATE customer SET "+ answer1 +" = '" + answer3 + "' WHERE customer_id=" + answer2;
                con.query(sql, function (err, result) {
                    if (err) {throw err; }
                    console.log(result.affectedRows + " record(s) updated");
                });
                rl.close();
            });
        });

    });
});