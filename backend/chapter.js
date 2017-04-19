// Load mongoose
var mongoose = require('mongoose');

// Define Schema for chapter.
var chapter = new mongoose.Schema({
	
	_id: {
		type: String,
		required: true
	},

	chapter_name: {
		type: String,
		required: true
	},

	data_type: {
		type: String
	},

	description: {
		type: String,
		required: true
	},

	instructor: {
		type: String,
		required: true
	},

	videos: [String],

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
module.exports =mongoose.model('Chapter', chapter);