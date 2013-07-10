define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			@bindEvents() #online offline events
			console.log "localstorage", window.localStorage["items"]

		bindEvents: ->
			document.addEventListener "deviceready", @onDeviceReady, false
			document.addEventListener "offline", @onOffline, false
			document.addEventListener "online", @onOnline, false

		onDeviceReady: ->
			console.log "deviceready"
		onOffline: ->
			console.log "offline"
		onOnline: ->
			console.log "online"