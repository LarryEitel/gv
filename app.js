// Generated by CoffeeScript 1.3.3
(function() {
  var app, express, http, omd, path, routes;

  path = require("path");

  express = require("express");

  routes = require("./routes");

  http = require("http");

  omd = new (require("outline-markdown")).Omd;

  app = express();

  app.configure("development", function() {
    app.set("port", process.env.PORT || 3000);
    app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
    return app.set("view options", {
      layout: false,
      pretty: true
    });
  });

  app.configure("test", function() {
    app.set("port", process.env.PORT || 3001);
    return app.set("view options", {
      layout: false,
      pretty: true
    });
  });

  app.configure("production", function() {
    app.set("port", process.env.PORT || 80);
    app.set("view options", {
      layout: false
    });
    return app.use(express.errorHandler());
  });

  app.configure(function() {
    app.set("views", path.join(__dirname, "views"));
    app.set("view engine", "jade");
    app.set("basepath", "/");
    app.set("docsSrcPath", path.join(__dirname, "docs"));
    app.set("docsDstPath", path.join(app.get("views"), 'docs'));
    app.use(express.favicon());
    app.use(express.logger("dev"));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    app.use(express["static"](path.join(__dirname, "public")));
    return app.use(express["static"](path.join(__dirname, "docs")));
  });

  omd.buildIndex('docs', app.set("docsSrcPath"), app.set("docsDstPath"), function(callback) {
    return console.log('buildIndex');
  });

  ['index', 'docs'].forEach(function(controller) {
    return require('./routes/' + controller)(app);
  });

  http.createServer(app).listen(app.get("port"), function() {
    return console.log("Express server listening on port " + app.get("port"));
  });

}).call(this);
