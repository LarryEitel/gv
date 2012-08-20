path       = require 'path'
omd        = new (require "outline-markdown").Omd 

module.exports = (app) ->
  app.get '/docs/*', (req, res, next) ->
    params = req.route.params
    if not params[0]
      next()
    else
      # console.log params
      # doc = {}
      # doc['params'] = params
      srcFileParts = params[0].split("/")
      srcName      = path.join(app.get("docsSrcPath"), srcFileParts.join(path.sep) + '.omd')
      #console.log 'srcFileParts', srcFileParts
      srcFileParts.pop()
      srcPath      = srcFileParts.join(path.sep)
      dstPath      = path.join(app.get("docsDstPath"), srcPath)

      omd.parse srcName, dstPath, (callback) ->
        console.log 'render', "docs/" + params[0]
        res.render "docs/" + params[0]

      res.end()


  # app.get '/docs/:doc', (req, res) ->
  #   res.render "docs/" + req.params.doc,
  #     title: "Docs"


  # app.get '/docs/of', (req, res) ->
  #   res.render "/docs/of",
  #     title: "Docs"


  # app.get '/docs/([^\/]+)\/?(.+)?/', (req, res, next) ->
  # app.get 
  #   path: '/docs/:doc'
  #   keys: [{ name: 'doc', optional: false }]
  #   regexp: /^\/docs\/(?:([^\/]+?))\/?$/i
  #   , (req, res, next) ->
  #     console.log req.params
  #     res.render "docs/doc",
  #       params: params
  #       doc: req.params.doc
  #       title: "Docs"

  app.get '/docs', (req, res) ->
    res.render "docs/index",
      title: "Docs"

