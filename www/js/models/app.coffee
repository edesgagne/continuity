#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'parse', 'routers/myrouter'], ($, Mobile, _, Parse, MyRouter) ->
	class window.App extends Parse.Object
		initialize: ->	
			console.log "app"
			@initRouter()
			@initMenu()
			
		initRouter: ->
			router = new MyRouter
			Parse.history.start()
		initMenu: ->
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