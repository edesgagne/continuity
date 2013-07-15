define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview', 'models/step', 'routers/myrouter'], ($, Mobile, _, Parse, StepList, StepListView, Step, MyRouter) ->
	class Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			@mode = "online" #temporary, change to "default" later
			@updatedOffline = false
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
