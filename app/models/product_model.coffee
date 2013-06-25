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


ProductSchema = database 'products', RECORD_VERSION,
  material_num: Number
  name: String
  category: String
  category_id: Number
  sub_category: String
  description: String
  unit_price: Number
  pallete_count: Number
  pallete_cost: Number
  case_count: Number
  case_cost: Number
  pack_count: Number
  pack_cost: Number
  unit_size: String

module.exports = ProductSchema