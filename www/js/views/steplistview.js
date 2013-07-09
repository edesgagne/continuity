// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'backbone'], function($, Mobile, _, Backbone) {
    var _ref;
    return window.StepListView = (function(_super) {
      __extends(StepListView, _super);

      function StepListView() {
        _ref = StepListView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      StepListView.prototype.tagName = 'div';

      StepListView.prototype.attributes = {
        'data-role': 'collapsible-set'
      };

      StepListView.prototype.initialize = function() {
        _.bindAll(this);
        return this.render();
      };

      StepListView.prototype.render = function() {
        this.collection.each(this.renderEach, this);
        return this;
      };

      StepListView.prototype.renderEach = function(step) {
        var element, stepView;
        stepView = new window.StepView({
          model: step
        });
        element = stepView.el;
        return $(this.el).append(element);
      };

      return StepListView;

    })(Backbone.View);
  });

}).call(this);
