// Load mongoose
var mongoose = require('mongoose');

// Define Schema for user.
var user = new mongoose.Schema({
	
	name: {
		type: String,
		required: true
	},

	email: {
		type: String,
		index: { unique: true },
		required: true
	},

	password: {
		type: String,
		required: true
	},

	enrolled: [String],

	dateCreated: {
		type: Date,
		default: Date.now
	},

	dateUpdated: {
		type: Date,
		default: Date.now
	}
});

// Exporting the Schema.
module.exports =mongoose.model('User', user);