module.exports = (app) ->
  {AddController} = app.locals
  {OrderController} = app.locals
  {pathRaw} = app.locals.path
  {pathFor} = app.locals.path
  
  app.get pathRaw('index'), (req, res) ->
    res.render 'index', view: 'index'

  app.get pathRaw('product.index'), AddController.index
  app.get pathRaw('product.new'), AddController.new
  app.post pathRaw('product.create'), AddController.create
  app.get pathRaw('product.import'), AddController.import
  app.get pathRaw('product.list'), AddController.list
  app.get pathRaw('order.index'), OrderController.index
  