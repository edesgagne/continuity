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
require ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/startview', 'models/uploader', 'models/app', 'models/queries'], 
($, Mobile, _, Parse, StartView, Uploader, App, Queries) ->
	
	#alert "starting app"
	
	Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"
	
	#requires parse
	window.uploader = new Uploader
	window.queries = new Queries
	
	#binds events to online/offline 
	#requires uploader
	new App 
	
	#requires app
	#so it will know if user is online/offline
	#so it will know whether to let them login/signup
	new StartView
