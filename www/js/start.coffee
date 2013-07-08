require.config 
	paths:
		'jquery': 'lib/jquery-1.8.3'
		'underscore': 'lib/underscore'
		'backbone': 'lib/backbone'
		'parse': 'lib/parse-1.2.8'
	shim:
		"lib/underscore":
			exports: "_"
		"lib/backbone":
			exports: "Backbone"
			
require ['models/app'], ->
	app = new App