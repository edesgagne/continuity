define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/appview', 'views/loginview'], 
($, Mobile, _, Parse, AppView, LoginView) ->
	class StartView extends Parse.View
		initialize: ->
			console.log 'start view'
			@render()
			
		render: ->
			#Parse.User.logOut();
			if Parse.User.current()
				new AppView
			else
				new LoginView