define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview', 'models/step', 'routers/myrouter'], ($, Mobile, _, Parse, StepList, StepListView, Step, MyRouter) ->
	class Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			#console.log "localstorage", window.localStorage["steplist"]
			@mode = "online" #temporary, change to "default" later
			@blocker = false
		getMode: ->
			return @mode
		# getBlocker: ->
		# 		return @blocker
		# 	updateBlocker: (newval)->
		# 		@blocker = newval
		updateMode: (newmode) ->
			oldmode = @mode
			@mode = newmode
			console.log 'newmode', @mode
			#also make sure to handle uploading to parse here 
			#if mode is online now
			#upload all local storage to parse
			
			#IMPLEMENT THIS NEXT
			if oldmode == "offline" and newmode =="online"
				#get what's in local storage
				coll = JSON.parse window.localStorage["steplist"]
				#upload to parse
				#everything has already been put in localstorage
				window.queries.updateCollectionOnline()

			#but, why do i need to upload to parse if it's displaying from localstorage?
			#because in app.coffee > setUpDevice
			#if the user goes to a new device, all their data is lsot
			#unless..everything is uploaded to parse
		
			
			
	
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
			

				
			#IMPLEMENT THIS NEXT
			
		displaySteps: ->
			if @mode == "offline" or @mode == "online"
				#always displays from localstorage
				#because its the most up to date
				console.log 'displaying offline'
				list = new StepList
				steps_array = JSON.parse window.localStorage["steplist"]
				for step in steps_array
					list.add step
				listview = new StepListView {collection: list}
			
				#display it
				element = listview.render().el
				$('[data-role="content"]').html element
				listview.jqdisplay()
			else
				console.error 'must be either online or offline'
