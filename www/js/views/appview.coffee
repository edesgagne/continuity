define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/beforestartview'], 
($, Mobile, _, Parse, BeforeStartView) ->
	class AppView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			console.log 'app view'
