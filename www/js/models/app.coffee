#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist'], ($, Mobile, _, Parse, Step, StepList) ->
	class App extends Parse.Object
		className: "App"
		initialize: ->	
			#window.localStorage.clear() #temporary
			@bindEvents()
			
			console.log "app"
			
		bindEvents: ->
			document.addEventListener "deviceready", @onDeviceReady, false
			document.addEventListener "offline", @onOffline, false
			document.addEventListener "online", @onOnline, false
		onDeviceReady: ->
			console.log "deviceready"
		onOffline: ->
			console.log "offline"
			window.uploader.updateMode "offline"
		onOnline: ->
			console.log "online"
			window.uploader.updateMode "online"

