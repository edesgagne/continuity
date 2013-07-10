define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.Uploader extends Parse.Object
		className: "Uploader"
		initialize: ->	
			console.log "uploader"
			#console.log "localstorage", window.localStorage["steplist"]
			@mode = "online" #change back to 'default' in production
		updateMode: (newmode) ->
			@mode = newmode
			console.log 'newmode', @mode
			#also make sure to handle uploading to parse here 
			#if mode is online now
			#upload all local storage to parse
		updateCollection: (coll) ->
			#update in local storage
			console.log 'updating collection'
			console.log coll
			window.localStorage["steplist"] = JSON.stringify coll
			#upload to parse if mode is online
			#it won't work to reply on updateMode
			#because if you're always online
			#nothing gets refreshed and uploaded
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
