define ['jquery', 'jquerymobile', 'underscore', 'parse'], 
($, Mobile, _, Parse) ->
	class LoginView extends Parse.View
		el: '[data-role="page"]'
		events:
			'submit form#login': 'logIn'
			'submit form#signup': 'signUp'
			
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
			@jqdisplay()
		logIn: ->
			if window.uploader.getMode() != "online"
				console.error "can only log in if online"
				return
			
			name = $('#login #name').val()
			pass = $('#login #pass').val()


			window.queries.logInUser(name, pass).then((students) ->
				window.queries.syncParseWithLocalStorage()
			).then ( ->
				window.location.reload()
			), (error) ->
				console.error 'there was an error logging in', error
				
		signUp: ->
			if window.uploader.getMode() != "online"
				console.error "can only sign up if online"
				return
				
			name = $('#signup #name').val()
			pass = $('#signup #pass').val()

			window.queries.signUpUser(name, pass).then((students) ->
				window.queries.saveAllObjects()
			).then( ->
				window.queries.syncParseWithLocalStorage()
			).then ( ->
				window.location.reload()
			# Everything is done!
			), (error) ->
				console.error 'there was an error signing up', error
			

		render: ->
			console.log 'login view'
			
			$(@el).html """
				<div style="padding: 20px">
				
				Login
				<form id="login">
				<input id="name" type="text" placeholder="Username"  />
				<input id="pass" type="password" placeholder="Password"  />
				<input type="submit" value="Submit" />
				</form>
				
				<br />
				<br />
				
				Sign Up
				<form id="signup">
				<input id="name" type="text" placeholder="Username"  />
				<input id="pass" type="password" placeholder="Password"  />
				<input type="submit" value="Submit" />
				</form>
				
				</div>
			
			"""
		jqdisplay: ->
			$(@el).trigger("pagecreate")
		#	$(@el).ready ->
		#		$.mobile.changePage $('[data-role="page"]')
			
