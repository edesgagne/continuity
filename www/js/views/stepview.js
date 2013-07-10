// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
    var StepView, _ref;
    return StepView = (function(_super) {
      __extends(StepView, _super);

      function StepView() {
        this.clicked = __bind(this.clicked, this);
        this.render = __bind(this.render, this);
        this.open = __bind(this.open, this);
        _ref = StepView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      StepView.prototype.tagName = 'div';

      StepView.prototype.attributes = {
        'data-role': 'collapsible',
        'data-collapsed': 'true'
      };

      StepView.prototype.events = {
        "click .submit": "clicked"
      };

      StepView.prototype.initialize = function() {
        var id, temp;
        _.bindAll(this, 'clicked');
        id = this.model.get('step_num');
        console.log(id);
        $(this.el).attr('id', id);
        this.model.on('openCollapsible', this.open);
        temp = "	\n		<h3>\n		<%= step_num %> : <%= title %>\n		</h3>\n	\n\n	<div style=\"opacity:0.5; text-shadow: none; font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px\"> \n	<%= description %>\n	</div>\n	\n\n	\n	<!-- add new strategy -->\n		\n	<% _.each(fields, function(field) { %> \n	\n	\n		<% if (field == \"phone number\") { %>\n		    <input type=\"tel\" name=\"\" class=\"textinput\" placeholder=\"Add <%= field %>\" value=\"\" type=\"text\" data-mini=\"false\" />\n	    \n		<% } else { %>\n		    <input name=\"\" class=\"textinput\" placeholder=\"Add <%= field %>\" value=\"\" type=\"text\" data-mini=\"false\" />\n		\n		<% } %>\n\n	<% }); %>\n	<input id=\"<%= step_num %>\" class=\"submit\" type=\"submit\" value=\"Submit\" />\n	\n	\n\n		\n	\n	\n		\n	\n	\n	\n		<!--display old strategies -->\n			<% if (strategies.length != 0) { %>\n			\n		<ol style=\"text-shadow: none; background-color: turquoise; padding: 10px; padding-left: 40px; border-radius: 10px\">\n		<% _.each(strategies, function(strat) { %> \n			<li style=\"font-size: 16px; padding: 5px\">\n				<%= strat %>\n			</li> \n		\n		<% }); %>\n		</ol>\n		\n		<% } %>\n	";
        return this.template = _.template(temp);
      };

      StepView.prototype.open = function() {
        console.log('triggered open');
        console.log($(this.el).attr('data-collapsed'));
        $(this.el).attr('data-collapsed', 'false');
        console.log($(this.el).attr('data-collapsed'));
        return $('[data-role="collapsible-set"]').collapsibleset("refresh");
      };

      StepView.prototype.render = function() {
        var content;
        content = this.template(this.model.toJSON());
        $(this.el).html(content);
        return this;
      };

      StepView.prototype.clicked = function(e) {
        var before, output, str_output;
        e.preventDefault();
        output = Array();
        $(this.el).find('.textinput').each(function() {
          output.push($(this).val());
          return $(this).val("");
        });
        str_output = output.toString();
        str_output = str_output.replace(",", " ");
        before = this.model.get('strategies');
        before.push(str_output);
        this.model.set({
          strategies: before
        });
        return console.log('updated strategies', this.model.get('strategies'));
      };

      return StepView;

    })(Parse.View);
  });

}).call(this);
