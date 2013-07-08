#
#
#
#
RECORD_VERSION = 1
#
#
#
#

mongoose = require('mongoose');
Schema = mongoose.Schema
ObjectId = Schema.ObjectId;

OrderSchema = new Schema
	total:
		type: String
		default: ''
	order_num:
		type: Number
		default: 1
	order_id: 
		type: String
		default: ''
	account: 
		type: String
		default: ''
	client: 
		type: String
		default: ''
	items: []




module.exports = mongoose.model 'Order', OrderSchema