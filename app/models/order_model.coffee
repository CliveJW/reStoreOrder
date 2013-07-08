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
		type: Number
		default: 0
	order_num:
		type: Number
		default: 0
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