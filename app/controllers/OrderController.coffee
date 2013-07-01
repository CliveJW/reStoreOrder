ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
ya = require('ya-csv')

module.exports = (app) ->

    class OrderController 
        @index = (req, res) ->
            res.render 'order/index'
        
        app.get '/products/search/', (req, res) ->
            ProductModel.find (err, products) ->
                res.send products

        app.get '/order/init', (req, res) ->
            order = new OrderModel
            order.save (err, result) ->
                res.send result
                console.log err
