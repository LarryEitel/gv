// Generated by CoffeeScript 1.3.3
(function() {

  module.exports = function(app) {
    return app.get('/', function(req, res, next) {
      return res.render("index", {
        title: "GrandView"
      });
    });
  };

}).call(this);
