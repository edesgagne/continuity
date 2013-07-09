require.config 
	paths:
		'jquery': 'lib/jquery-1.8.3'
		'jquerymobile': 'lib/jquery-mobile/jquery.mobile-1.3.1'
		'underscore': 'lib/underscore'
		'backbone': 'lib/backbone'
		'parse': 'lib/parse-1.2.8'
	shim:
		"lib/underscore":
			exports: "_"
		"lib/backbone":
			exports: "Backbone"
			
require ['models/app', "underscore"], ->
	app = new App