require.config 
	paths:
		'jquery': 'lib/jquery-1.8.3'
		'jquerymobile': 'lib/jquery-mobile/jquery.mobile-1.3.1'
		'underscore': 'lib/underscore'
		'backbone': 'lib/backbone'
		'parse': 'lib/parse-1.2.8'
	shim:
		"underscore":
			exports: "_"
		"backbone":
			deps: ['underscore', 'jquery']
			exports: "Backbone"
			
require ['models/app'], ->
	app = new App