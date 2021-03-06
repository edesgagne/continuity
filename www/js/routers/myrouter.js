// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'views/homeview', 'views/steplistview', 'views/helpview', 'views/activitylistview'], function($, Mobile, _, Parse, HomeView, StepListView, HelpView, ActivityListView) {
    var MyRouter, _ref;
    return MyRouter = (function(_super) {
      __extends(MyRouter, _super);

      function MyRouter() {
        _ref = MyRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      MyRouter.prototype.routes = {
        "": "showHome",
        "safety": "showSafety",
        "help": "showHelp",
        "activities": "showActivities"
      };

      MyRouter.prototype.initialize = function(routeHandler) {
        console.log("router");
        this.routeHandler = routeHandler;
        return this.bindMenu();
      };

      MyRouter.prototype.bindMenu = function() {
        return $(document).on("click", "a:not([data-bypass])", function(evt) {
          var href, root;
          href = {
            prop: $(this).prop("href"),
            attr: $(this).attr("href")
          };
          root = location.protocol + "//" + location.host + "/";
          if (href.prop && href.prop.slice(0, root.length) === root) {
            evt.preventDefault();
            Parse.history.navigate(href.attr, {
              trigger: true
            });
          }
          return $('#myPanel').panel("close");
        });
      };

      MyRouter.prototype.basics = function(title) {
        console.log("show " + title);
        return $('[data-role="header"] > h3').html(title);
      };

      MyRouter.prototype.showHome = function() {
        var title;
        title = "Home";
        this.basics(title);
        return this.routeHandler.showView(new HomeView);
      };

      MyRouter.prototype.showActivities = function() {
        var title;
        title = "Activities";
        this.basics(title);
        return this.routeHandler.showView(new ActivityListView);
      };

      MyRouter.prototype.showSafety = function() {
        var title;
        title = "Safety Planning";
        this.basics(title);
        return this.routeHandler.showView(new StepListView);
      };

      MyRouter.prototype.showHelp = function() {
        var title;
        title = "Get Help";
        this.basics(title);
        return this.routeHandler.showView(new HelpView);
      };

      return MyRouter;

    })(Parse.Router);
  });

}).call(this);
