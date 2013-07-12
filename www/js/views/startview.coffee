define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/loginview', 'views/appview', 'models/usersetup'], 
($, Mobile, _, Parse, LoginView, AppView, UserSetup) ->
	class StartView extends Parse.View
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			console.log 'start view'
			
			#Parse.User.logOut()
			
			# Parse.User.logIn "johnny", "1234",
			# 	success: (user) ->
			# 		console.log 'success logging in'
			# 	error: (user, error) ->
			# 		console.error 'error logging in', error

			if Parse.User.current()
				new UserSetup
				new AppView
			else
				new LoginView
			@
