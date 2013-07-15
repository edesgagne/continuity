define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview', 'models/step', 'routers/myrouter'], ($, Mobile, _, Parse, StepList, StepListView, Step, MyRouter) ->
	class Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			@mode = "online" #temporary, change to "default" later
		getMode: ->
			return @mode
		updateMode: (newmode) ->
			oldmode = @mode
			@mode = newmode
			
			console.log 'newmode', @mode
			
			if oldmode == "offline" and newmode =="online"
				#get what's in local storage
				coll = JSON.parse window.localStorage["steplist"]
				#upload to parse
				#everything has already been put in localstorage
				window.queries.updateCollectionOnline()
		updateCollection: (coll) ->
			#update in local storage
			console.log 'updating collection'
			console.log coll
			window.localStorage["steplist"] = JSON.stringify coll
			
			#upload to parse if mode is online
			#it won't work to reply on updateMode
			#because if you're always online
			#nothing gets refreshed and uploaded
			if @mode == "online"
				console.log 'gonna update online...'
				#uses the version in local storage
				window.queries.updateCollectionOnline()