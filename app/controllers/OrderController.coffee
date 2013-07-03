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
            order.save (err, result) ->
                res.send result
                console.log err

        app.get '/order/drop/:name', (req, res) ->
            console.log req.params
            doc = new PDFDocument
            doc.info['Title'] = 'Test'
            doc.info['Author'] = "Alan Watts - with re-store-order"

            doc.text 'This is a simple tokenSecret'
            doc.write 'THING.pdf'

            dbClient = new Dropbox.Client(

                key: '7uir6n2ds0k58gq'
                secret: 'h518ydj517kmpul'
                sandbox: false
                token: tok.dboxT
                tokenSecret: tok.dboxS
            )

            file.readFile "/home/dev/docs/THING.pdf", (error, data) ->
  
              # No encoding passed, readFile produces a Buffer instance
                console.log error if error
            
                client.writeFile "/apps/re-store-order/" + req.params.name, data, (error, stat) ->
                    console.log error  if error else res.send stat




# The image has been succesfully written.

