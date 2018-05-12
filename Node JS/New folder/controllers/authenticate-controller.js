var express = require('express');
var con = require('./../config');
exports.authenticate = function (req, res){
	var username = req.body.username;
	var password = req.body.password;
	con.query('SELECT * FROM accounts WHERE username = ?',[username], function(error, results, fields){
		if(error) {
			res.json({
				status: false,
				message:'error'
			})
		}else{
			if(results.length > 0) {
				if(results[0].password == pasword){
					res.json({
						status: true,
						message:'Login successful'
					})
				}else{
					res.json({
						status:false,
						message:'Username and password does not match'
					});
				}
			}
			else{
				res.json({
					status:false,
					message:'Username does not exists'
				})
			}
		}
	});
}