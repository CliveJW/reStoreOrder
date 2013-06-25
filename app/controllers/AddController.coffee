ProductModel = require('../models/product_model')
ya = require('ya-csv')
module.exports = (app) ->
  {pathFor} = app.locals.path

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
      reader = ya.createCsvFileReader("/home/dev/projects/frep-test/app/list.csv",
        separator: "\:"
        quote: "\""
        escape: "\""
        comment: ""
      )
      reader.addListener "data", (data) ->
        product = new ProductModel
        product.material_num = data[0]
        product.sub_category = data[13]
        product.description = data[1]
        product.unit_price = data[3].replace("r ", "").replace ",", ""
        product.pallete_count = data[10]
        product.pallete_cost = data[6].replace("r ", "").replace ",", ""
        product.case_count = data[8]
        product.case_cost = data[5].replace("r ", "").replace ",", ""
        product.pack_count = data[7]
        product.pack_cost = data[4].replace("r ", "").replace ",", ""
        product.unit_size = data[2]
        console.log product
        product.save (err) ->
          console.log 'Saved New product'

