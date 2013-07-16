// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
    var LoginView, _ref;
    return LoginView = (function(_super) {
      __extends(LoginView, _super);

      function LoginView() {
        _ref = LoginView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      LoginView.prototype.el = '[data-role="page"]';

      LoginView.prototype.events = {
        'submit form#login': 'logIn',
        'submit form#signup': 'signUp'
      };

      LoginView.prototype.initialize = function() {
        _.bindAll(this, 'logIn', 'signUp', 'render', 'jqdisplay');
        this.render();
        return this.jqdisplay();
      };

      LoginView.prototype.logIn = function() {
        var name, pass;
        if (window.uploader.getMode() !== "online") {
          console.error("can only log in if online");
          return;
        }
        name = $('#login #name').val();
        pass = $('#login #pass').val();
        return window.queries.logInUser(name, pass).then(function(students) {
          return window.queries.parseToLocalStorage();
        }).then((function() {
          return window.location.reload();
        }), function(error) {
          return console.error('there was an error logging in', error);
        });
      };

      LoginView.prototype.signUp = function() {
        var name, pass;
        if (window.uploader.getMode() !== "online") {
          console.error("can only sign up if online");
          return;
        }
        name = $('#signup #name').val();
        pass = $('#signup #pass').val();
        return window.queries.signUpUser(name, pass).then(function(students) {
          return window.queries.saveSteps();
        }).then((function() {
          return window.location.reload();
        }), function(error) {
          return console.error('there was an error signing up', error);
        });
      };

      LoginView.prototype.render = function() {
        console.log('login view');
        return $(this.el).html("	<div style=\"padding: 20px\">\n	\n	Login\n	<form id=\"login\">\n	<input id=\"name\" type=\"text\" placeholder=\"Username\"  />\n	<input id=\"pass\" type=\"password\" placeholder=\"Password\"  />\n	<input type=\"submit\" value=\"Submit\" />\n	</form>\n	\n	<br />\n	<br />\n	\n	Sign Up\n	<form id=\"signup\">\n	<input id=\"name\" type=\"text\" placeholder=\"Username\"  />\n	<input id=\"pass\" type=\"password\" placeholder=\"Password\"  />\n	<input type=\"submit\" value=\"Submit\" />\n	</form>\n	\n	</div>\n");
      };

      LoginView.prototype.jqdisplay = function() {
        return $(this.el).trigger("pagecreate");
      };

      return LoginView;

    })(Parse.View);
  });

}).call(this);
