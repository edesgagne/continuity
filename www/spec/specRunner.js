// Generated by CoffeeScript 1.6.3
(function() {
  require.config({
    baseUrl: '../js',
    paths: {
      jquery: "lib/jquery",
      jquerymobile: "lib/jquery-mobile/jquery-mobile",
      underscore: "lib/underscore",
      parse: "lib/parse",
      jasmine: "../spec/lib/jasmine/jasmine",
      "jasmine-html": "../spec/lib/jasmine/jasmine-html",
      "jasmine-jquery": "../spec/lib/jasmine-jquery"
    },
    shim: {
      underscore: {
        exports: "_"
      },
      parse: {
        deps: ["underscore", "jquery"],
        exports: "Parse"
      },
      jasmine: {
        exports: "jasmine"
      },
      "jasmine-html": {
        deps: ["jasmine"],
        exports: "jasmine"
      },
      "jasmine-jquery": {
        deps: ["jquery", "jasmine", "jasmine-html"],
        exports: "jasmine"
      }
    }
  });

  require(["jquery", "jasmine-jquery"], function($, jasmine) {
    var htmlReporter, jasmineEnv, specs;
    jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;
    htmlReporter = new jasmine.HtmlReporter();
    jasmineEnv.addReporter(htmlReporter);
    jasmineEnv.specFilter = function(spec) {
      return htmlReporter.specFilter(spec);
    };
    specs = [];
    specs.push("../spec/activities/activitySpec");
    specs.push("../spec/activities/activityListSpec");
    return $(function() {
      return require(specs, function(spec) {
        return jasmineEnv.execute();
      });
    });
  });

}).call(this);
