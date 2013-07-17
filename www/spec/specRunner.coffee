require.config
	baseUrl: '../js'
	paths:
		jquery: "lib/jquery"
		jquerymobile: "lib/jquery-mobile/jquery-mobile"
		underscore: "lib/underscore"
		parse: "lib/parse"
		'text': 'lib/text'
		jasmine: "../spec/lib/jasmine/jasmine"
		"jasmine-html": "../spec/lib/jasmine/jasmine-html"
		"jasmine-jquery": "../spec/lib/jasmine-jquery"
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
	
	specs.push "../spec/activities/activitySpec"
	specs.push "../spec/activities/activityListSpec"
	specs.push "../spec/activities/activityViewSpec"
	specs.push "../spec/activities/activityListViewSpec"
	
	$ ->
		require specs, (spec) ->
			jasmineEnv.execute()


