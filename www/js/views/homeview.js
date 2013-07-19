// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/hometemplate.html'], function($, Mobile, _, Parse, hometemplate) {
    var HomeView, _ref;
    return HomeView = (function(_super) {
      __extends(HomeView, _super);

      function HomeView() {
        _ref = HomeView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      HomeView.prototype.tagName = "div";

      HomeView.prototype.template = _.template(hometemplate);

      HomeView.prototype.initialize = function() {
        return _.bindAll(this, 'render', 'close');
      };

      HomeView.prototype.render = function() {
        return $(this.el).html(this.template({
          user: window.localStorage["user"]
        }));
      };

      HomeView.prototype.close = function() {
        this.undelegateEvents();
        $(this.el).removeData().unbind();
        this.remove();
        this.unbind();
        return Parse.View.prototype.remove.call(this);
      };

      return HomeView;

    })(Parse.View);
  });

}).call(this);
