// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
    var PopupView, _ref;
    return PopupView = (function(_super) {
      __extends(PopupView, _super);

      function PopupView() {
        _ref = PopupView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      PopupView.prototype.tagName = 'div';

      PopupView.prototype.attributes = {
        "data-role": "popup"
      };

      PopupView.prototype.initialize = function() {
        _.bindAll(this, 'render');
        this.render();
        return this.jqdisplay();
      };

      PopupView.prototype.render = function() {
        $(this.el).html("<p style='padding: 10px'>" + this.options.text + "</p>");
        return this;
      };

      PopupView.prototype.jqdisplay = function() {
        return $(this.el).popup();
      };

      PopupView.prototype.open = function() {
        return $(this.el).popup("open");
      };

      return PopupView;

    })(Parse.View);
  });

}).call(this);
