define ['jquery', 'jquerymobile', 'underscore', 'parse'], 
($, Mobile, _, Parse) ->
	class App extends Parse.Object
		className: "App"
		initialize: ->	
			console.log "app"
			@bindEvents()
			
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

