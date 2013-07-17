// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'views/activityview'], function($, Mobile, _, Parse, ActivityView) {
    var ActivityListView, _ref;
    return ActivityListView = (function(_super) {
      __extends(ActivityListView, _super);

      function ActivityListView() {
        _ref = ActivityListView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ActivityListView.prototype.el = '[data-role="content"]';

      ActivityListView.prototype.initialize = function() {
        _.bindAll(this, 'render', 'rerender');
        this.collection.on('change:isCompleted', this.rerender, this);
        return this.render();
      };

      ActivityListView.prototype.getCurrentId = function() {
        var arr, nextid;
        arr = this.collection.pluck("isCurrent");
        nextid = arr.indexOf(true) + 1;
        return nextid;
      };

      ActivityListView.prototype.getCurrent = function() {
        var next, nextid;
        nextid = this.getCurrentId();
        next = this.collection.get(nextid);
        return next;
      };

      ActivityListView.prototype.render = function() {
        var av, next;
        $(this.el).html("");
        next = this.getCurrent();
        av = new ActivityView({
          model: next
        });
        return $(this.el).append(av.el);
      };

      ActivityListView.prototype.rerender = function(changedmodel) {
        var cur, curid, next;
        console.log('rerender');
        curid = this.getCurrentId();
        console.log(curid);
        if (curid === this.collection.models.length) {
          console.log('finished list');
        } else {
          cur = this.collection.get(curid);
          next = this.collection.get(curid + 1);
          console.log(this.collection.pluck("isCurrent"));
          cur.notCurrent();
          next.current();
          console.log(this.collection.pluck("isCurrent"));
          return this.render();
        }
      };

      return ActivityListView;

    })(Parse.View);
  });

}).call(this);
