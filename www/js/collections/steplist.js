// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'backbone'], function($, Mobile, _, Backbone) {
    var _ref;
    return window.StepList = (function(_super) {
      __extends(StepList, _super);

      function StepList() {
        _ref = StepList.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      StepList.prototype.model = Step;

      return StepList;

    })(Backbone.Collection);
  });

}).call(this);
