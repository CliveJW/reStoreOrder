ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
ClientModel = require('../models/client_model')

module.exports = (app) ->

    class PrevOrderController 
        
        app.get '/client/orders/:acc', (req, res) ->
            console.log req.params
            id = req.params.acc
            OrderModel.find {account: id}, "order_num", 
                sort:
                    order_num: -1
            , (err, orders) ->
                console.log orders
                res.send orders

