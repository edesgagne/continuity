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
        console.log("app");
        this.setUpUser();
        return this.setUpDevice();
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

      App.prototype.setUpUser = function() {
        var currentUser;
        if (window.uploader.getMode() !== "online") {
          console.log("sorry, you must be online to set up the user");
          return;
        }
        currentUser = Parse.User.current();
        if (currentUser.get('isSetUp') === true) {
          console.log('user already set up');
          return;
        }
        console.log('still here');
        this.setUpSafety();
        currentUser.set({
          isSetUp: true
        });
        return currentUser.save();
      };

      App.prototype.setUpSafety = function() {
        var currentUser, list, st, stepJSON, _i, _len, _ref1, _results;
        console.log('setting up safety');
        list = new StepList;
        stepJSON = [
          {
            "step_num": 1,
            "title": "Warning Signs",
            "description": "Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:",
            "fields": ["warning sign"]
          }, {
            "step_num": 2,
            "title": "Coping Strategies",
            "description": "Internal coping strategies: things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):",
            "fields": ["coping strategy"]
          }, {
            "step_num": 3,
            "title": "People",
            "description": "People that provide distraction:",
            "fields": ["name", "phone number"]
          }, {
            "step_num": 4,
            "title": "Settings",
            "description": "Social settings that provide distraction:",
            "fields": ["place"]
          }
        ];
        list.add(stepJSON);
        currentUser = Parse.User.current();
        _ref1 = list.models;
        _results = [];
        for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
          st = _ref1[_i];
          st.set({
            user: currentUser
          });
          st.setACL(new Parse.ACL(currentUser));
          _results.push(st.save());
        }
        return _results;
      };

      App.prototype.setUpDevice = function() {
        if (window.uploader.getMode() !== "online") {
          console.error("sorry, you must be online to set up the device");
          return;
        }
        return uploader.syncParseWithLocalStorage();
      };

      return App;

    })(Parse.Object);
  });

}).call(this);
