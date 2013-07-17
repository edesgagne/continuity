// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/activitytemplate.html'], function($, Mobile, _, Parse, activitytemplate) {
    var ActivityView, _ref;
    return ActivityView = (function(_super) {
      __extends(ActivityView, _super);

      function ActivityView() {
        _ref = ActivityView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ActivityView.prototype.template = _.template(activitytemplate);

      ActivityView.prototype.tagName = 'div';

      ActivityView.prototype.events = {
        'click #unchecked': 'checked'
      };

      ActivityView.prototype.initialize = function() {
        _.bindAll(this, 'render', 'checked');
        this.render();
        return this.model.bind('change:isCompleted', this.render);
      };

      ActivityView.prototype.render = function() {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
      };

      ActivityView.prototype.checked = function() {
        console.log('checked');
        return this.model.complete();
      };

      return ActivityView;

    })(Parse.View);
  });

}).call(this);
