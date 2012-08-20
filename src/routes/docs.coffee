otl        = require("outline-markdown")

module.exports = (app) ->
  app.get '/docs/*', (req, res, next) ->
    params = req.route.params
    if not params[0]
      next()
    else
      # console.log params
      doc = {}
      doc['params'] = params
      paramParts = params[0].split("/")
      doc['paramParts'] = paramParts

      doc['rootdir'] = app.get "docsSrcPath"
      doc['docsDstPath'] = app.get "docsDstPath"
      doc['srcName'] = paramParts.pop()
      doc['srcName'] += '.ol'
      doc['path'] = paramParts.join('/')
      doc['subdir'] = paramParts.join('/')
      doc['dstPath'] = doc['docsDstPath']
      console.log doc
      otl.parseOl doc['rootdir'], doc['subdir'], doc['srcName'], doc['dstPath'], (err, callback) ->
        console.log 'run it'
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

