ClientModel = require('../models/client_model')
ya = require('ya-csv')

module.exports = (app) ->

    class ClientController 
        app.get '/client/import', (req, res) ->
              reader = ya.createCsvFileReader("/home/clivew/client_list.csv",
                separator: "\,"
                quote: "\""
                escape: "\""
                comment: ""
              )
              reader.addListener "data", (data) ->
                String::reduceWhiteSpace = ->
                  @replace /\s+/g, " "
                client = new ClientModel
                client.acc = data[0]
                client.name = data[1]
                client.delivery_address = data[2]
                client.postal_address = data[3]
                client.telephone = data[4]
                client.fax = data[5]
                client.email = data[6]
                client.type = data[8]
                client.category = data[9]
                client.normal_terms = data[11]
                client.early_terms = data[12]
                client.contact1 = data[13]
                client.contact1_position = data[14]
                client.contact1_mobile_phone = data[15]
                client.contact1_email = data[16]
                client.contact2 = data[17]
                client.contact1_position = data[18]
                client.contact2_mobile_phone = data[19]
                client.contact2_email = data[20]
                client.sales_code = data[25]
                
                console.log client
                client.save (err) ->
                    res.send 'Import Complere'

        app.get '/client/list', (req, res) ->
            ClientModel.find (err, posts) ->
                res.send posts