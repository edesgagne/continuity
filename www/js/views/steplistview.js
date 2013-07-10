// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
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
        return this.collection.bind("change", this.rerender, this);
      };

      StepListView.prototype.render = function() {
        this.collection.each(this.renderEach, this);
        return this;
      };

      StepListView.prototype.jqdisplay = function() {
        console.log('jq display');
        $('[data-role="collapsible-set"]').collapsibleset();
        $('.textinput').textinput();
        return $('[type="submit"]').button();
      };

      StepListView.prototype.rerender = function(changedmodel) {
        $(this.el).html("");
        this.render();
        console.log('rerendering collection');
        this.jqdisplay();
        return window.uploader.updateCollection(this.collection);
      };

      StepListView.prototype.renderEach = function(step) {
        var element, stepView;
        stepView = new window.StepView({
          model: step
        });
        element = stepView.render().el;
        return $(this.el).append(element);
      };

      return StepListView;

    })(Parse.View);
  });

}).call(this);
