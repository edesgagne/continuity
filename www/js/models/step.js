// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['lib/backbone'], function(Backbone) {
    var _ref;
    return window.Step = (function(_super) {
      __extends(Step, _super);

      function Step() {
        _ref = Step.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Step.prototype.defaults = {
        step_num: 0,
        title: '',
        description: 'Write some strategies.',
        fields: [],
        strategies: []
      };

      return Step;

    })(Backbone.Model);
  });

}).call(this);
