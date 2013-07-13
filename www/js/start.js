// Generated by CoffeeScript 1.6.3
(function() {
  require.config({
    paths: {
      'jquery': 'lib/jquery-1.8.3',
      'jquerymobile': 'lib/jquery-mobile/jquery.mobile-1.3.1',
      'underscore': 'lib/underscore',
      'parse': 'lib/parse-1.2.8'
    },
    shim: {
      "underscore": {
        exports: "_"
      },
      "parse": {
        deps: ['underscore', 'jquery'],
        exports: "Parse"
      }
    }
  });

  require(['jquery', 'jquerymobile', 'underscore', 'parse', 'views/startview', 'global/app', 'global/queries', 'global/uploader'], function($, Mobile, _, Parse, StartView, App, Queries, Uploader) {
    Parse.initialize("pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx");
    window.queries = new Queries;
    window.uploader = new Uploader;
    window.app = new App;
    return new StartView;
  });

}).call(this);
