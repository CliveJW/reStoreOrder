ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
ya = require('ya-csv')

module.exports = (app) ->

    class OrderController 
        @index = (req, res) ->
            res.render 'order/index'
        
        app.get '/products/search/:query', (req, res) ->
            console.log req.params
            ProductModel.find {words: new RegExp(req.params.query, 'i')}, (err, products) ->
                console.log err
                res.send products

        app.get '/order/init', (req, res) ->
            order = new OrderModel
            order.save (err, result) ->
                res.send result
                console.log err
