define ['jquery', 'jquerymobile', 'underscore', 'parse'], 
($, Mobile, _, Parse) ->
	class Uploader extends Parse.Object
		className: "Uploader"
		mode: "online" #temporary, change to "default" later
		updatedOffline: false
		initialize: ->	
			_.bindAll @, 'getUpdatedOffline', 'setUpdatedOffline', 'getMode', 'updateMode'
			console.log "uploader"
			#@mode = "online" 
			#@updatedOffline = false
		getUpdatedOffline: ->
			return @wasUpdatedOffline
		setUpdatedOffline: (newval)->
			console.log 'updated offline: ', newval
			@updatedOffline = newval
		getMode: ->
			return @mode
		updateMode: (newmode) ->
			oldmode = @mode
			@mode = newmode
			console.log 'newmode', @mode
			
			if oldmode == "offline" and newmode =="online" and @updatedOffline == true
				console.log 'doing online updates automatically'
				@updatedOffline = false
				window.queries.updateCollectionOnline()
