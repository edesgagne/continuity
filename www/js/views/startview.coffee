define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/loginview', 'views/appview', 'routers/myrouter', 'models/routehandler'], 
($, Mobile, _, Parse, LoginView, AppView, MyRouter, RouteHandler) ->
	class StartView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			console.log 'start view'
			
			if Parse.User.current()
				new AppView
				new MyRouter(new RouteHandler)
				Parse.history.start() #({pushState: true}) 
			else
				new LoginView
