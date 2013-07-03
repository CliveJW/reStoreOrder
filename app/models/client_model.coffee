mongoose = require('mongoose');
Schema = mongoose.Schema
ObjectId = Schema.ObjectId;

ClientSchema = new Schema
	acc: Number
	name: String
	delivery_address: String
	postal_address: String
	telephone: String
	fax: String
	email: String
	type: String
	category: String
	normal_terms: String
	early_terms: String
	contact1: String
	contact1_position: String
	contact1_mobile_phone: String
	contact1_email: String
	contact2: String
	contact2_position: String
	contact2_mobile_phone: String
	contact2_email: String
	sales_code: String
	orders: []

module.exports = mongoose.model 'Client', ClientSchema