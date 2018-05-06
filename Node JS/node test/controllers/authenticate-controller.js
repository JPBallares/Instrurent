    var connection = require('./../config');
    module.exports.authenticate=function(req,res){
        var username=req.body.username;
        const password=req.body.password;
        connection.query('SELECT * FROM accounts WHERE username = ?',[username], function (error, results, fields) {
          if (error) {
              res.json({
                status:false,
                message:'there are some error with query'
                })
          }else{
            if(results.length >0){
                if(password==results[0].password){
                    res.json({
                        status:true,
                        message:'successfully authenticated'
                    })
                }else{
                    res.json({
                      status:false,
                      message:"Username and password does not match"
                     });
                }
             
            }
            else{
              res.json({
                  status:false,    
                message:"Username does not exist"
              });
            }
          }
        });
    }