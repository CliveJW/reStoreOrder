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
	order_id: Number
	account: Number
	client: String
	items: []

module.exports = mongoose.model 'Order', OrderSchema