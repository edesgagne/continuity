require.config
	#baseUrl: ''
	paths:
		'jquery': 'lib/jquery'
		'jquerymobile': 'lib/jquery-mobile/jquery-mobile'
		'underscore': 'lib/underscore'
		#'backbone': 'lib/backbone'
		'parse': 'lib/parse'
		#'jasmine': '../spec/lib/jasmine-1.2.0/jasmine'
		#'jasmine-html': '../spec/lib/jasmine-1.2.0/jasmine-html'
		#'spec': '../spec'
		'text': 'lib/text'
	shim:
		"underscore":
			exports: "_"
		# "backbone":
		# 	deps: ['underscore', 'jquery']
		# 	exports: "Backbone"
		"parse":
			deps: ['underscore', 'jquery']
			exports: "Parse"

require ['jquery', 'jquerymobile', 'underscore', 'parse', 
'views/startview', 'global/app', 'global/queries', 'global/uploader'], 
($, Mobile, _, Parse, StartView, App, Queries, Uploader) ->
	#temporary until wrapped in "on device ready"
	$(document).ready ->
		console.log 'start'

		#alert "starting app"

		Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"

		#requires parse
		window.queries = new Queries
		window.uploader = new Uploader

		#binds online/offline events
		#requires uploader
		window.app = new App

		#requires app
		#so it will know if user is online/offline
		#so it will know whether to let them login/signup
		new StartView
