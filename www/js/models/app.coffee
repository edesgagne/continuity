#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'backbone', 'routers/myrouter'], ($, Mobile, _, Backbone, MyRouter) ->
	class window.App extends Backbone.Model
		initialize: ->	
			console.log "app"
			router = new MyRouter
			Backbone.history.start()
			@initMenu()
		
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
					Backbone.history.navigate href.attr, true
		
				#close the panel
				#$('#myPanel').panel("close")