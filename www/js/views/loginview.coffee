define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/beforestartview'], 
($, Mobile, _, Parse, BeforeStartView) ->
	class LoginView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		el: '[data-role="page"]'
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			console.log 'login view'
