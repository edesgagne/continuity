require.config
	
	#base url not working
	#baseURL: '../js/',
	#urlArgs: 'cb=' + Math.random(),
	paths:
		jquery: "../js/lib/jquery-1.8.3"
		jquerymobile: "../js/lib/jquery-mobile/jquery.mobile-1.3.1"
		underscore: "../js/lib/underscore"
		parse: "../js/lib/parse-1.2.8"
		jasmine: "lib/jasmine-1.2.0/jasmine"
		"jasmine-html": "lib/jasmine-1.2.0/jasmine-html"
		"jasmine-jquery": "lib/jasmine-jquery"

	
	#'text': '../js/lib/text'
	#'spec': 'spec'
	shim:
		underscore:
			exports: "_"

		parse:
			deps: ["underscore", "jquery"]
			exports: "Parse"

		jasmine:
			exports: "jasmine"

		"jasmine-html":
			deps: ["jasmine"]
			exports: "jasmine"

		"jasmine-jquery":
			deps: ["jquery", "jasmine", "jasmine-html"]
			exports: "jasmine"


#jasmine-jquery is dependent on jasmine-html
#which is dependent on jasmine
#so everything gets loaded in the require call
require ["jquery", "jasmine-jquery"], ($, jasmine) ->
	
	#technically requiring jquery isn't necessary
	#because jasmine-jquery is dependent on it anyways
	jasmineEnv = jasmine.getEnv()
	jasmineEnv.updateInterval = 1000
	htmlReporter = new jasmine.HtmlReporter()
	jasmineEnv.addReporter htmlReporter
	jasmineEnv.specFilter = (spec) ->
		htmlReporter.specFilter spec

	specs = []
	specs.push "activities/activitySpec"

	$ ->
		require specs, (spec) ->
			jasmineEnv.execute()

