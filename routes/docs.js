// Generated by CoffeeScript 1.3.3
(function() {
  var otl;

  otl = require("outline-markdown");

  module.exports = function(app) {
    app.get('/docs/*', function(req, res, next) {
      var doc, paramParts, params;
      params = req.route.params;
      if (!params[0]) {
        return next();
      } else {
        doc = {};
        doc['params'] = params;
        paramParts = params[0].split("/");
        doc['paramParts'] = paramParts;
        doc['rootdir'] = app.get("docsSrcPath");
        doc['docsDstPath'] = app.get("docsDstPath");
        doc['srcName'] = paramParts.pop();
        doc['srcName'] += '.ol';
        doc['path'] = paramParts.join('/');
        doc['subdir'] = paramParts.join('/');
        doc['dstPath'] = doc['docsDstPath'];
        console.log(doc);
        otl.parseOl(doc['rootdir'], doc['subdir'], doc['srcName'], doc['dstPath'], function(err, callback) {
          console.log('run it');
          return res.render("docs/" + params[0]);
        });
        return res.end();
      }
    });
    return app.get('/docs', function(req, res) {
      return res.render("docs/index", {
        title: "Docs"
      });
    });
  };

}).call(this);