// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist'], function($, Mobile, _, Parse, Step, StepList) {
    var App, _ref;
    return App = (function(_super) {
      __extends(App, _super);

      function App() {
        _ref = App.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      App.prototype.className = "App";

      App.prototype.initialize = function() {
        this.bindEvents();
        return console.log("app");
      };

      App.prototype.bindEvents = function() {
        document.addEventListener("deviceready", this.onDeviceReady, false);
        document.addEventListener("offline", this.onOffline, false);
        return document.addEventListener("online", this.onOnline, false);
      };

      App.prototype.onDeviceReady = function() {
        return console.log("deviceready");
      };

      App.prototype.onOffline = function() {
        console.log("offline");
        return window.uploader.updateMode("offline");
      };

      App.prototype.onOnline = function() {
        console.log("online");
        return window.uploader.updateMode("online");
      };

      return App;

    })(Parse.Object);
  });

}).call(this);
