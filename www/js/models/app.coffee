define ['lib/backbone', 'routers/myrouter'], (Backbone, MyRouter) ->
	class window.App extends Backbone.Model
		initialize: ->	
			console.log "app"
			router = new MyRouter
			Backbone.history.start()