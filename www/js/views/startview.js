// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'views/loginview', 'views/appview', 'routers/myrouter', 'models/routehandler'], function($, Mobile, _, Parse, LoginView, AppView, MyRouter, RouteHandler) {
    var StartView, _ref;
    return StartView = (function(_super) {
      __extends(StartView, _super);

      function StartView() {
        _ref = StartView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      StartView.prototype.initialize = function() {
        _.bindAll(this, 'render');
        return this.render();
      };

      StartView.prototype.render = function() {
        console.log('start view');
        if (Parse.User.current()) {
          new AppView;
          new MyRouter(new RouteHandler);
          return Parse.history.start();
        } else {
          return new LoginView;
        }
      };

      return StartView;

    })(Parse.View);
  });

}).call(this);
