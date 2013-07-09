// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'backbone'], function($, Mobile, _, Backbone) {
    var _ref;
    return window.MyRouter = (function(_super) {
      __extends(MyRouter, _super);

      function MyRouter() {
        _ref = MyRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      MyRouter.prototype.initialize = function() {
        return console.log("router");
      };

      MyRouter.prototype.routes = {
        "": "showHome",
        "safety": "showSafety"
      };

      MyRouter.prototype.showHome = function() {
        console.log("show home..");
        $('[data-role="content"]').html("Home page.");
        return $('[data-role="header"] > h3').html("Home");
      };

      MyRouter.prototype.showSafety = function() {
        console.log("show safety..");
        $('[data-role="content"]').html("Safety page.");
        return $('[data-role="header"] > h3').html("Safety");
      };

      return MyRouter;

    })(Backbone.Router);
  });

}).call(this);
