// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'views/beforestartview'], function($, Mobile, _, Parse, BeforeStartView) {
    var AppView, _ref;
    return AppView = (function(_super) {
      __extends(AppView, _super);

      function AppView() {
        _ref = AppView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      AppView.prototype.initialize = function() {
        _.bindAll(this);
        return this.render();
      };

      AppView.prototype.render = function() {
        return console.log('app view');
      };

      return AppView;

    })(Parse.View);
  });

}).call(this);
