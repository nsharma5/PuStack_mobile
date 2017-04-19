// Load mongoose
var mongoose = require('mongoose');

// Define Schema for subject.
var subject = new mongoose.Schema({
	
	_id: {
		type: String,
		required: true
	},

	subject_name: {
		type: String,
		required: true
	},

	data_type: {
		type: String
	},

	chapters: [String],

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
module.exports =mongoose.model('Subject', subject);