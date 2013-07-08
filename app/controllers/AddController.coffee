ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
ya = require('ya-csv')

module.exports = (app) ->

  class AddController 
    @index = (req, res) ->
      res.render 'product', title: 'Product Index', view: 'product'


    @new = (req, res) ->
      res.render 'product/new', title: 'New Product', view: 'Products new'

    @create = (req, res) ->
      prod = req.body
      product = new ProductModel
      product.description = prod.description
      product.unit_price = prod.price
      product.pallete_count = prod.pCount
      product.crate_count = prod.cCount
      product.box_count = prod.bCount
      product.save (err) ->
        console.log product
        res.render 'product/new', title: 'New Product', view: 'Products new'

    @import = (req, res) ->
      reader = ya.createCsvFileReader("main_prod_list.csv",
        separator: "\:"
        quote: "\""
        escape: "\""
        comment: ""
      )
      reader.addListener "data", (data) ->
        String::reduceWhiteSpace = ->
          @replace /\s+/g, " "
        product = new ProductModel
        product.material_num = data[0]
        product.sub_category = data[13]
        product.description = data[1].reduceWhiteSpace()
        product.unit_price = data[3].replace("R ", "")
        product.pallete_count = data[9]
        product.pallete_cost = data[6].replace("R ", "")
        product.case_count = data[8]
        product.case_cost = data[5].replace("R ", "")
        product.pack_count = data[7]
        product.pack_cost = data[4].replace("R ", "")
        product.unit_size = data[2]
        words_init = data[1].split " "
        words = []
        for word in words_init
          if word == ''
          else
            words.push word
        product.words = words
        console.log product
        product.save (err) ->

    @list = (req, res) ->
      ProductModel.find (err, products) -> 
        res.render 'product/list', products: products





