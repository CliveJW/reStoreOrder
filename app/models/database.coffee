Schema = require('jugglingdb').Schema

connection = {}
connection.database = 're-store-order'
connection.host = '192.168.1.254'
connection.safe = true # turn fire-and-forget off (mongodb)

console.log 'connecting to mongo', connection.database
schema = new Schema 'mongodb', connection

module.exports = db =

    schema: schema

    versioned: (collectionName, version, schemaHash) ->

            collection = schema.define collectionName, schemaHash


            #
            # beforesave hook updates updated_at


            return collection