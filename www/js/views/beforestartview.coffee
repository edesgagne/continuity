define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/startview'], 
($, Mobile, _, Parse, StartView) ->
	class BeforeStartView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			console.log 'before start view'
			new StartView
			@
