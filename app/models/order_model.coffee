#
#
#
#
RECORD_VERSION = 1
#
#
#
#

database = require('./database').versioned


OrderSchema = database 'orders', RECORD_VERSION,
	order_id: Number
	account: Number
	client: String
	items: []

module.exports = OrderSchema