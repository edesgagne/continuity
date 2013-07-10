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
require ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/app', 'routers/myrouter', 'models/uploader'], 
($, Mobile, _, Parse, App, MyRouter, Uploader) ->
	getStarted = ->
		#initialize the uploader
		#should be accessible globally
		window.uploader = new Uploader
		#initialize the app
		app = new App

	$(
		
		Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"

		#see if user is already logged in
		if Parse.User.current()
			console.log 'no need to sign in, user already logged'
			getStarted()
		#otherwise, log them in
		else
			Parse.User.logIn "jane", "4321",
				success: (user) ->
					console.log 'success logging in'
					getStarted()
				error: (user, error) ->
					console.error 'error logging in', error
	)
