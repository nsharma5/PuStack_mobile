var express = require('express');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var autoIncrement = require('mongoose-auto-increment');

// Get all the schemas.
var User = require('./user');
var Subject = require('./subject');
var Chapter = require('./chapter');

// Define local connection string with MongoDB.
var connectionString = 'mongodb://testuser1:testuser1!@cluster0-shard-00-00-ufyzn.mongodb.net:27017,cluster0-shard-00-01-ufyzn.mongodb.net:27017,cluster0-shard-00-02-ufyzn.mongodb.net:27017/Cluster0?ssl=true&replicaSet=Cluster0-shard-0&authSource=admin';

// Connect to local MongoDB. 
mongoose.Promise = global.Promise;
var connection = mongoose.connect(connectionString);

// Use auto increment module.
autoIncrement.initialize(connection);

// Initialize app by using Express framework.
var app = express();

// Use Body Parser (Helps to process incoming requests).
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

// Set default port 3000 or custom if defined by user externally.
port = process.env.PORT || 3000

// GET users by their emails.
app.get('/api/user/:id', function(request, response){
    User.findById(request.params.id, function(error, user){

    	// In case of any error.
    	if (error) {
    		response.status(500);
    		response.json({ message: "Invalid User", data: [] });
    		console.log(request.params.id)
    	}

    	// Get user's details
    	else {
    		response.status(200);
    		response.json({ message: "Found User", data: user });
    	}
    	
    });
});

// GET all subjects.
app.get('/api/subjects', function(request, response) {
	
	Subject.find(function(error, subjects){

		// In case of any error.
    	if (error) {
    		response.status(500);
    		response.json({ message: "No Subjects Found.", data: [] });
    	}

    	// Get subjects' details
    	else {
    		response.status(200);
    		response.json({ message: "Found All Subjects", data: subjects });
    	}
	});
});

// GET a specific subject.
app.get('/api/subjects/:id', function(request, response){

	Subject.find(request.params.id, function(error, subject){

		// In case of any error.
    	if (error) {
    		response.status(500);
    		response.json({ message: "No Subject Found.", data: [] });
    	}

    	// Get a subject's details
    	else {
    		response.status(200);
    		response.json({ message: "Found Subject", data: subject });
    	}
	});
});

// GET all chapters.
app.get('/api/chapters', function(request, response) {
	
	Subject.find(function(error, chapters){

		// In case of any error.
    	if (error) {
    		response.status(500);
    		response.json({ message: "No Chapters Found.", data: [] });
    	}

    	// Get chapters' details
    	else {
    		response.status(200);
    		response.json({ message: "Found All Chapters", data: chapters });
    	}
	});
});

// GET a specific chapter.
app.get('/api/chapters/:id', function(request, response){

	Chapter.find(request.params.id, function(error, subject){

		// In case of any error.
    	if (error) {
    		response.status(500);
    		response.json({ message: "No Chapter Found.", data: [] });
    	}

    	// Get a chapter's details
    	else {
    		response.status(200);
    		response.json({ message: "Found Chapter", data: subject });
    	}
	});
});

// PUT - update user details.
app.put('/api/user/:id', function(request, response) {

	User.findOne(request.params.id, function(error, user){

		//If user does not exist.
		if(error) {
			response.status(404);
			response.json({ message: "User not found.", data: [] });
		}

		else {
			user.name = request.body.name;
			user.email = request.body.email;
			user.password = request.body.password;
			user.enrolled = request.body.enrolled;

			// Save it to database.
			user.save( function(error) {

				// Error handling.
				if(error) {
					response.status(500);
					response.json({ message: "User not updated.", data: [] });
				}

				else {
					response.status(200);
					response.json({ message: "User's details updated.", data: user });
				}
			});
		}
		console.log(user);
	});
});


// POST new user details.
app.post('/api/user', function(request, response) {

	// Make a new user.
	var new_user = new User();
	new_user.name = request.body.name;
	new_user.email = request.body.email;
	new_user.password = request.body.password;

	// Save it to database.
	new_user.save( function(error) {

		// Error handling.
		if(error) {
			response.status(300);

			// If the email is not unique.
			if(error.code === 11000) {
				response.json({ message: "This email exists already.", data: [] });
			}

			else {
				response.json({ message: "User not added.", data: [] });
				console.log(new_user);
			}
		}

		else {
			response.status(201);
			response.json({ message: "User added to the database.", data: new_user });
		}
	});
});

app.listen(port);
console.log('Server running on this port:' + port);
