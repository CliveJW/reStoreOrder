ProductModel = require('../models/product_model')
OrderModel = require('../models/order_model')
Dropbox = require('dropbox')
ya = require('ya-csv')
PDFDocument = require 'pdfkit'
file = require 'fs'
module.exports = (app) ->

    class OrderController

       
        
        # tok = {dboxT: '', dboxS: ''}
        # client = new Dropbox.Client(
        #         key: "7uir6n2ds0k58gq"
        #         secret: "h518ydj517kmpul"
        # )
        # authDriver = new Dropbox.Drivers.NodeServer(8191)

        # client.authDriver authDriver

        # client.authenticate (error, client) ->
        #     console.log client.oauth.token
        #     console.log client.oauth.tokenSecret
        #     tok.dboxT = client.oauth.token
        #     tok.dboxS = client.oauth.tokenSecret

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
                token: 'zt7x36ky0xbh1wnp'
                tokenSecret: '90a5if2jza6ls5p'
            )
            d = new Date()
            curr_date = d.getDate()
            curr_month = d.getMonth() + 1 #Months are zero based
            curr_year = d.getFullYear()
            doc = new PDFDocument
            doc.fontSize(24)
            doc.info['Title'] = 'Test'
            doc.info['Author'] = "Alan Watts - with re-store-order"
            doc.text 'Order: ' + order.order_num 
            doc.text order.client.name 
            doc.text "Account: " + order.client.acc
            doc.text "Date: ( " + curr_date + "-" + curr_month + "-" + curr_year + " )"

            doc.text "Contact: " + order.client.contact1
            doc.text "Number: " + order.client.contact1_mobile_phone
            doc.text ""
            doc.text ""

            for item in order.items
                doc.fontSize(14)
                doc.text item.name 
                doc.text "      x " + item.count + " " + item.unit + "(s) with " + item.discount  + "% discount @ R" + item.price
                doc.text " "
            doc.text " "
            doc.fontSize(24)
            doc.text "Total: " + order.total
            doc.write path, (err) ->

               

                file.readFile path, (error, data) ->
      
                  # No encoding passed, readFile produces a Buffer instance
                    console.log error
                
                    dbClient.writeFile "/apps/re-store-order/"+path, data, (error, stat) ->
                        res.redirect '/'


        app.get '/order/previous', (req, res) ->
            res.render 'order/previous' 

