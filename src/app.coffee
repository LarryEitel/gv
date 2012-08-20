path       = require("path")
express    = require("express")
routes     = require("./routes")
http       = require("http")
omd        = new (require "outline-markdown").Omd 

app = express()

# development configuration
app.configure "development", ->
  app.set "port", process.env.PORT or 3000
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  app.set "view options",
    layout: false
    pretty: true

# test configuration
app.configure "test", ->
  #app.set "port", process.env.PORT or 3001
  app.set "port", process.env.PORT or 3001
  app.set "view options",
    layout: false
    pretty: true

# production configuration
app.configure "production", ->
  app.set "port", process.env.PORT or 80
  app.set "view options",
    layout: false
  app.use express.errorHandler()

# app configuration
app.configure ->
  app.set "views", path.join(__dirname, "views")
  app.set "view engine", "jade"
  app.set "basepath", "/"
  app.set "docsSrcPath", path.join(__dirname, "docs")
  app.set "docsDstPath", path.join(app.get("views"),'docs')
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express["static"](path.join(__dirname, "public"))
  app.use express["static"](path.join(__dirname, "docs"))

omd.buildIndex 'docs', app.set("docsSrcPath"), app.set("docsDstPath"), (callback) ->
  console.log 'buildIndex'

['index', 'docs'].forEach (controller)->
  require('./routes/'+controller)(app)

# fire up server
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

