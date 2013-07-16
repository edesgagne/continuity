// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['jquery', 'jquerymobile', 'underscore', 'parse'], function($, Mobile, _, Parse) {
    var StepView, _ref;
    return StepView = (function(_super) {
      __extends(StepView, _super);

      function StepView() {
        _ref = StepView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      StepView.prototype.main_template = _.template("	<h3>\n	<%= step_num %> : <%= title %>\n	</h3>\n\n\n<div style=\"opacity:0.5; text-shadow: none; font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px\"> \n<%= description %>\n</div>\n\n\n\n<!-- add new strategy -->\n	\n<% _.each(fields, function(field) { %> \n\n\n	<% if (field == \"phone number\") { %>\n	    <input type=\"tel\" name=\"\" class=\"textinput\" placeholder=\"Add <%= field %>\" value=\"\" type=\"text\" data-mini=\"false\" />\n    \n	<% } else { %>\n	    <input name=\"\" class=\"textinput\" placeholder=\"Add <%= field %>\" value=\"\" type=\"text\" data-mini=\"false\" />\n	\n	<% } %>\n\n<% }); %>\n<input id=\"<%= step_num %>\" class=\"submit\" type=\"submit\" value=\"Submit\" />\n	\n	");

      StepView.prototype.sub_template = _.template("<!--display old strategies -->\n	<% if (strategies.length != 0) { %>\n	\n<ol style=\"list-style-type: none; text-shadow: none; border:5px solid gray; padding: 10px; padding-left: 30px; border-radius: 10px\">\n<% i = 0 %>\n<% _.each(strategies, function(strat) { %> \n	<li id=\"<%= i %>\" style=\"font-size: 16px; padding: 10px\">\n		<a class=\"delete\" style=\"margin-right: 10px;\" href=\"#\" data-bypass=\"true\" data-iconpos=\"notext\" data-role=\"button\" data-icon=\"delete\" data-mini=\"true\" data-inline=\"true\">Delete</a>\n		\n		<% if(strat.indexOf(\"|\") == -1) { %>\n			<%= strat %>\n		<% } else { %>\n			<% arr = strat.split(\" | \");\n			str = arr[0];\n			phone = arr[1];\n			%>\n			<%= str %>\n			\n			<a data-inline=\"true\" data-mini=\"true\" data-role=\"button\" href=\"tel:<%= phone %>\">\n			Call Phone: <%= phone %>\n			</a>\n			\n			\n		<% } %>\n	</li> \n	<% i = i + 1 %>\n\n<% }); %>\n</ol>\n\n<% } %>");

      StepView.prototype.tagName = 'div';

      StepView.prototype.attributes = {
        'data-role': 'collapsible',
        'data-collapsed': 'true'
      };

      StepView.prototype.events = {
        "click .submit": "add",
        "click .delete": "remove"
      };

      StepView.prototype.initialize = function() {
        var id;
        _.bindAll(this, 'render', 'add', 'remove');
        id = this.model.get('step_num');
        $(this.el).attr('id', id);
        return this.content = this.main_template(this.model.toJSON());
      };

      StepView.prototype.render = function() {
        var sub_content;
        sub_content = this.sub_template(this.model.toJSON());
        $(this.el).html(this.content);
        $(this.el).append(sub_content);
        return this;
      };

      StepView.prototype.add = function(e) {
        var output, str_output;
        e.preventDefault();
        output = Array();
        $(this.el).find('.textinput').each(function() {
          output.push($(this).val());
          return $(this).val("");
        });
        str_output = output.toString();
        str_output = str_output.replace(",", " | ");
        this.model.get('strategies').push(str_output);
        this.model.trigger('change', this.model);
        return console.log('added strategies', this.model.get('strategies'));
      };

      StepView.prototype.remove = function(e) {
        var arr, id, num, todelete;
        e.preventDefault();
        todelete = $(e.currentTarget).parent();
        id = todelete.attr('id');
        num = parseInt(id);
        arr = this.model.get('strategies');
        arr.splice(num, 1);
        this.model.set({
          strategies: arr
        });
        return console.log('updated strategies', this.model.get('strategies'));
      };

      return StepView;

    })(Parse.View);
  });

}).call(this);
