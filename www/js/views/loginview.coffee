define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/logintemplate.html', 'views/popupview'], 
($, Mobile, _, Parse, logintemplate, PopupView) ->
	class LoginView extends Parse.View
		el: '[data-role="page"]'
		template: _.template logintemplate
		events:
			'submit form#login': 'logIn'
			'submit form#signup': 'signUp'
			
		initialize: ->
			_.bindAll @, 'logIn', 'signUp', 'render', 'jqdisplay'
			@render()
			@jqdisplay()
			

		logIn: (e)->
			
			e.preventDefault()
			
			name = $('#login #name').val()
			pass = $('#login #pass').val()


			window.queries.logInUser(name, pass).then((students) ->
				window.queries.parseToLocalStorage()
			).then ( ->
				window.location.reload()
			), (error) ->
				console.error error.message
				alert("Error: " + error.message.toLowerCase())
				window.location.reload()
				# setTimeout ( ->
				# 	popup = new PopupView
				# 		text: 'There was an error logging in: ' + error.message
				# 	popup.open()
				# ), 500 #waits until page is reloaded
				# 
				# setTimeout (->
				# 	window.location.reload()
				# ), 3000
				
		signUp: (e)->
			e.preventDefault()
				
			name = $('#signup #name').val()
			pass = $('#signup #pass').val()

			window.queries.signUpUser(name, pass).then((students) ->
				window.queries.saveSteps()
			).then ( ->
				window.location.reload()
			# Everything is done!
			), (error) ->
				console.error error.message
				alert("Error: " + error.message.toLowerCase())
				window.location.reload()
				#waits until page is reloaded automatically
				#because of jquery or parse or something
				#so the popup only comes after parse reloads the page
				#alternate solution: stop parse from reloading the page
				# setTimeout ( ->
				# 	popup = new PopupView
				# 		text: 'There was an error signing up: ' + error.message
				# 	popup.open()
				# ), 500 
				# 
				# setTimeout (->
				# 	window.location.reload()
				# ), 3000
			

		render: ->
			console.log 'login view'
			
			$(@el).html @template
		jqdisplay: ->
			$(@el).trigger("pagecreate")
		#	$(@el).ready ->
		#		$.mobile.changePage $('[data-role="page"]')
			
