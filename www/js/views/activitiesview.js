// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'models/activity', 'views/activityview', 'text!templates/activitiestemplate.html'], function($, Mobile, _, Parse, Activity, ActivityView, activitiestemplate) {
    var ActivitiesView, _ref;
    return ActivitiesView = (function(_super) {
      __extends(ActivitiesView, _super);

      function ActivitiesView() {
        _ref = ActivitiesView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ActivitiesView.prototype.el = '[data-role="content"]';

      ActivitiesView.prototype.initialize = function() {
        _.bindAll(this, 'render');
        return this.render();
      };

      ActivitiesView.prototype.render = function() {
        return $(this.el).html('hello');
      };

      return ActivitiesView;

    })(Parse.View);
  });

}).call(this);
