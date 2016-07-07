var express = require("express");
var app = express();
var bodyParser = require("body-parser");

app.use(bodyParser.json());

var candies = [];
var nextId = 1;

app.get("/candies/:id",function(req, res){
	var foundCandy;
	var targetId = parseInt(req.params.id);
	for (var i = 0; i < candies.length; i++){
		if (candies[i].id === targetId){
			foundCandy = candies[i];
		}
	}
	res.send(foundCandy);
});

app.post("/candies",function(req, res){
	console.log(req.body);
	var newCandy = req.body;
	if (newCandy.id === undefined){
		newCandy.id = nextId;
		nextId++;
	}
	candies.push(newCandy);
	console.log(newCandy); 
	res.send(newCandy);
});
app.listen(3000);