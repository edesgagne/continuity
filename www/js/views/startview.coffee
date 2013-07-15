define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/loginview', 'views/appview', 'routers/myrouter'], 
($, Mobile, _, Parse, LoginView, AppView, MyRouter) ->
	class StartView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			console.log 'start view'
			
			if Parse.User.current()
				new AppView
				new MyRouter
				Parse.history.start() 
				#({pushState: true}) 
				#only works if tested with http
				
			else
				new LoginView
