// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
    var Activity, _ref;
    return Activity = (function(_super) {
      __extends(Activity, _super);

      function Activity() {
        _ref = Activity.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Activity.prototype.className = "Activity";

      Activity.prototype.defaults = {
        id: 0,
        description: "",
        isCompleted: false,
        isCurrent: false,
        isLast: false
      };

      Activity.prototype.complete = function() {
        return this.set({
          isCompleted: true
        });
      };

      Activity.prototype.undoComplete = function() {
        return this.set({
          isCompleted: false
        });
      };

      Activity.prototype.notCurrent = function() {
        return this.set({
          isCurrent: false
        });
      };

      Activity.prototype.current = function() {
        return this.set({
          isCurrent: true
        });
      };

      return Activity;

    })(Parse.Object);
  });

}).call(this);
