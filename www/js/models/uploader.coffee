define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview', 'models/step'], ($, Mobile, _, Parse, StepList, StepListView, Step) ->
	class Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			#console.log "localstorage", window.localStorage["steplist"]
			@mode = "online" #change back to 'default' in production
		getMode: ->
			return @mode
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
				@updateCollectionOnline()
			# 	#upload everything to parse
			# 	
			# 	
			# 	
			# 	query = new Parse.Query Step
			# 	#get all of the steps that are linked to the current user
			# 	query.equalTo "user", currentUser
			# 	query.find
			# 		success: (results) ->
			# 			list = new StepList
			# 			#fill up the step list
			# 			for r in results
			# 				list.add r
			# 			steps = JSON.parse window.localStorage["steplist"]
			# 			list.reset(steps)
			
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
				@updateCollectionOnline()
			
		updateCollectionOnline: ->	
			#upload everything to parse
			query = new Parse.Query Step
			#get all of the steps that are linked to the current user
			currentUser = Parse.User.current()
			query.equalTo "user", currentUser
			query.ascending('step_num')
			query.find
				success: (results) ->
					steps = JSON.parse window.localStorage["steplist"]
					
					i = 0
					#loop through results and steps
					#should be same length
					while i < results.length
						
						obj = results[i]
						#console.log 'obj', obj
						#updated = steps[i] #returns a json object
						updated = null
						#make sure step num matches
						$.each steps, (index, element) ->
							if element.step_num == obj.get('step_num')
								updated = element
								return
						#console.log 'steps', updated["strategies"]
						
						if obj.get('step_num') != updated["step_num"]
							console.error "steps are out of order"
							
						obj.set
							strategies: updated["strategies"]
						obj.save()
						
						i = i + 1
					console.log 'synced online'
				error: (e) ->
					console.error 'error', e
			#IMPLEMENT THIS NEXT
			
		displaySteps: ->
			if @mode == "offline" or @mode == "online"
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
			# else if @mode == "online"
			# 	#do i ever need to load from parse?
			# 	#if i store everything in parse here anyways
			# 	#then loading from parse is the same as loading from locstor
			# 	#parse is just a backup of all my data
			# 	console.log 'displaying online'
			# 	#duplicate code....
			# 	currentUser = Parse.User.current()
			# 
			# 	query = new Parse.Query Step
			# 	#get all of the steps that are linked to the current user
			# 	query.equalTo "user", currentUser
			# 	query.find
			# 		success: (results) ->
			# 			list = new StepList
			# 			#fill up the step list
			# 			for r in results
			# 				list.add r
			# 			#end of duplicate code...
			# 		
			# 			#sort the step list using "comparator" method in steplist
			# 			list.sort()
			# 			#create a view for the steplist
			# 			listview = new StepListView {collection: list}
			# 		
			# 			#display it
			# 			element = listview.render().el
			# 			$('[data-role="content"]').html element
			# 			listview.jqdisplay()
			else
				console.error 'must be either online or offline'
