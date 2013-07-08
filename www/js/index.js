// Generated by CoffeeScript 1.6.3
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  $(function() {
    var _ref, _ref1, _ref2, _ref3, _ref4;
    console.log("ready");
    window.MyRouter = (function(_super) {
      __extends(MyRouter, _super);

      function MyRouter() {
        _ref = MyRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      MyRouter.prototype.routes = {
        "": "index",
        "steps": "showSteps"
      };

      MyRouter.prototype.index = function() {
        console.log("show index..");
        $('[data-role="content"]').html("Home page.");
        return $('[data-role="header"] > h3').html("Home");
      };

      MyRouter.prototype.showSteps = function() {
        var element;
        console.log("show steps");
        $('[data-role="content"]').html("");
        $('[data-role="header"] > h3').html("Steps");
        this.list = new StepList;
        this.list.add(new Step({
          title: 'Step 1: Warning Signs',
          description: 'Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:',
          fields: ['warning sign']
        }));
        this.list.add(new Step({
          title: 'Step 2: Coping Strategies',
          description: 'Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):',
          fields: ['coping strategy']
        }));
        this.list.add(new Step({
          title: 'Step 3: People',
          description: 'People that provide distraction:',
          fields: ['name', 'phone number']
        }));
        this.list.add(new Step({
          title: 'Step 4: Settings',
          description: 'Social settings that provide distraction:',
          fields: ['place']
        }));
        this.listview = new StepListView({
          collection: this.list
        });
        element = this.listview.render().el;
        $('[data-role="content"]').html(element);
        $('[data-role="content"] > div').collapsibleset();
        $('.textinput').textinput();
        return $('[type="submit"]').button();
      };

      return MyRouter;

    })(Backbone.Router);
    window.StepListView = (function(_super) {
      __extends(StepListView, _super);

      function StepListView() {
        _ref1 = StepListView.__super__.constructor.apply(this, arguments);
        return _ref1;
      }

      StepListView.prototype.tagName = 'div';

      StepListView.prototype.attributes = {
        'data-role': 'collapsible-set'
      };

      StepListView.prototype.initialize = function() {
        _.bindAll(this);
        return this.render;
      };

      StepListView.prototype.render = function() {
        this.collection.each(this.renderEach, this);
        return this;
      };

      StepListView.prototype.renderEach = function(step) {
        var element, stepView;
        stepView = new window.StepView({
          model: step
        });
        element = stepView.render().el;
        return $(this.el).append(element);
      };

      return StepListView;

    })(Backbone.View);
    window.StepList = (function(_super) {
      __extends(StepList, _super);

      function StepList() {
        _ref2 = StepList.__super__.constructor.apply(this, arguments);
        return _ref2;
      }

      StepList.prototype.model = window.Step;

      return StepList;

    })(Backbone.Collection);
    window.StepView = (function(_super) {
      __extends(StepView, _super);

      function StepView() {
        this.render = __bind(this.render, this);
        _ref3 = StepView.__super__.constructor.apply(this, arguments);
        return _ref3;
      }

      StepView.prototype.tagName = 'div';

      StepView.prototype.attributes = {
        'data-role': 'collapsible',
        'data-collapsed': 'true'
      };

      StepView.prototype.initialize = function() {
        var temp;
        _.bindAll(this);
        temp = "\n<h3>\n<%= title %> \n</h3>\n\n<div style=\"font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px\"> \n<%= description %>\n</div>\n\n\n<!-- add new strategy -->\n<% _.each(fields, function(field) { %> \n	<input name=\"\" class=\"textinput\" placeholder=\"Add <%= field %>\" value=\"\" type=\"text\" data-mini=\"false\" />\n<% }); %>\n\n<input type=\"submit\" value=\"Submit\" />\n\n\n\n\n<!--display old strategies -->\n<% _.each(strategies, function(strat) { %> <li><%= strat %></li> <% }); %>\n\n";
        return this.template = _.template(temp);
      };

      StepView.prototype.render = function() {
        var content;
        content = this.template(this.model.toJSON());
        $(this.el).html(content);
        return this;
      };

      return StepView;

    })(Backbone.View);
    window.Step = (function(_super) {
      __extends(Step, _super);

      function Step() {
        _ref4 = Step.__super__.constructor.apply(this, arguments);
        return _ref4;
      }

      Step.prototype.defaults = {
        title: 'Step 0',
        description: 'Write some strategies.',
        fields: [],
        strategies: []
      };

      return Step;

    })(Backbone.Model);
    new MyRouter;
    Backbone.history.start();
    return $(document).on("click", "a:not([data-bypass])", function(evt) {
      var href, root;
      href = {
        prop: $(this).prop("href"),
        attr: $(this).attr("href")
      };
      root = location.protocol + "//" + location.host + "/";
      if (href.prop && href.prop.slice(0, root.length) === root) {
        evt.preventDefault();
        Backbone.history.navigate(href.attr, true);
      }
      return $('#myPanel').panel("close");
    });
  });

}).call(this);
