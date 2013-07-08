define ['lib/backbone'], (Backbone) ->
	class window.MyRouter extends Backbone.Router
		initialize: ->
			console.log "router"
		routes:
			"": "showHome"
		showHome: ->
			#log
			console.log "show home.."