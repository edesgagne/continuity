#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'parse', 'routers/myrouter'], ($, Mobile, _, Parse, MyRouter) ->
	class window.App extends Parse.Object
		className: "App"
		initialize: ->	
			console.log "app"
			#console.log 'true or false', @initParse()
			@initParse()
			#@initRouter()
			#@initMenu()
		initParse: ->
			Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", "CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"
			Parse.User.logIn "johnny", "1234",
				success: (user) ->
					console.log 'success logging in'
					#initialize the router
					router = new MyRouter
					Parse.history.start()
					#initialize the menu
					#whenever a link in the menu is clicked
					#it tells the backbone router to navigate there
					$(document).on "click", "a:not([data-bypass])", (evt) ->
						href =
							prop: $(this).prop("href")
							attr: $(this).attr("href")

						root = location.protocol + "//" + location.host + "/"
						if href.prop and href.prop.slice(0, root.length) is root
							evt.preventDefault()
							Parse.history.navigate href.attr, true

						#close the panel
						$('#myPanel').panel("close")
		 			# Do stuff after successful login.
				error: (user, error) ->
					console.error 'error logging in', error
					alert 'wrong username or password'
					# The login failed. Check error to see why.
		# initRouter: ->
		# 	router = new MyRouter
		# 	Parse.history.start()
		# initMenu: ->
		# 	#whenever a link in the menu is clicked
		# 	#it tells the backbone router to navigate there
		# 	$(document).on "click", "a:not([data-bypass])", (evt) ->
		# 		href =
		# 			prop: $(this).prop("href")
		# 			attr: $(this).attr("href")
		# 
		# 		root = location.protocol + "//" + location.host + "/"
		# 		if href.prop and href.prop.slice(0, root.length) is root
		# 			evt.preventDefault()
		# 			Parse.history.navigate href.attr, true
		# 
		# 		#close the panel
		# 		$('#myPanel').panel("close")