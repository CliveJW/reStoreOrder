ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
Dropbox = require('dropbox')
ya = require('ya-csv')
PDFDocument = require 'pdfkit'
file = require 'fs'
module.exports = (app) ->

    class OrderController

       
        
        tok = {dboxT: '', dboxS: ''}
        client = new Dropbox.Client(
                key: "7uir6n2ds0k58gq"
                secret: "h518ydj517kmpul"
        )
        authDriver = new Dropbox.Drivers.NodeServer(8191)

        client.authDriver authDriver

        client.authenticate (error, client) ->
            tok.dboxT = client.oauth.token
            tok.dboxS = client.oauth.tokenSecret

        @index = (req, res) ->
            res.render 'order/index'
        
        app.get '/products/search/:query', (req, res) ->
            console.log req.params
            ProductModel.find {words: new RegExp(req.params.query, 'i')}, (err, products) ->
                console.log err
                res.send products

        app.get '/order/init', (req, res) ->

            order = new OrderModel
            order.order_id = order._id
            OrderModel.find {}, "order_num", 
                sort:
                    order_num: -1
            , (err, orders) ->
                if orders[0]?
                    order.order_num = orders[0].order_num + 1
                else
                    order.order_num = 1
                order.save (err, result) ->
                    res.send result

        app.post '/order/saveOrder', (req, res) ->

            OrderModel.findOne {order_id: req.body.order_id}, (err, order) ->
                console.log req.body
                order.account = req.body.client.acc
                order.client = req.body.client.name
                order.items = req.body.items

                order.save (result) ->


        app.post '/order/drop', (req, res) ->
            order = req.body
            console.log order
            path = "orders/" + (order.client.name.replace RegExp(" ", "g"), "_")+"_"+order.order_num + '.pdf'
            dbClient = new Dropbox.Client(
                key: '7uir6n2ds0k58gq'
                secret: 'h518ydj517kmpul'
                sandbox: false
                token: tok.dboxT
                tokenSecret: tok.dboxS
            )
            doc = new PDFDocument
            doc.info['Title'] = 'Test'
            doc.info['Author'] = "Alan Watts - with re-store-order"

            doc.text 'Order :: ' + order.order_num
            doc.down
            doc.text "Account: " + order.client.acc
            doc.text order.client.name
            doc.text " "

            for item in order.items
                doc.text (item.name + " X " + item.count + " " + item.unit + "(s) with " + item.discount  + "% discount @ R" + item.price)
                doc.down
                doc.down
                doc.text " "
                doc.text " "
                doc.text " "
            doc.text "Total: " + order.total
            doc.write path, (err) ->

               

                file.readFile path, (error, data) ->
      
                  # No encoding passed, readFile produces a Buffer instance
                    console.log error
                
                    client.writeFile "/apps/re-store-order/"+path, data, (error, stat) ->
                        res.redirect '/'


        app.get '/order/previous', (req, res) ->
            res.render 'order/previous' 

