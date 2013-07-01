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
textSearch = require('mongoose-text-search')
Schema = mongoose.Schema
ObjectId = Schema.ObjectId;

ProductSchema = new Schema
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
  words: []

ProductSchema.plugin(textSearch)
ProductSchema.index { words: 'text' }

module.exports = mongoose.model 'Product', ProductSchema