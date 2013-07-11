require.config 
	paths:
		'jquery': 'lib/jquery-1.8.3'
		'jquerymobile': 'lib/jquery-mobile/jquery.mobile-1.3.1'
		'underscore': 'lib/underscore'
		#'backbone': 'lib/backbone'
		'parse': 'lib/parse-1.2.8'
	shim:
		"underscore":
			exports: "_"
		# "backbone":
		# 	deps: ['underscore', 'jquery']
		# 	exports: "Backbone"
		"parse":
			deps: ['underscore', 'jquery']
			exports: "Parse"

require ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/app', 'routers/myrouter', 'models/uploader', 'views/startview'], 
($, Mobile, _, Parse, App, MyRouter, Uploader, StartView) ->
	
	$(#temporary, to be replaced with 'device ready'
	
		Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"

		window.uploader = new Uploader
		
		new StartView
	)
