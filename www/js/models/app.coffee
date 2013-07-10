#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.App extends Parse.Object
		className: "App"
		initialize: ->	
			console.log "app"
			#one time, only when user signs up
			#uploads all the steps to parse.com
			@setUpUser() 
			#each time user is on new device
			#re-set up local storate
			#puts all the steps from parse.com in localstorage
			@setUpDevice() 
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

		setUpUser: ->
			if window.uploader.mode != "online"
				console.log "sorry, you must be online to set up the user"
				return
				
			currentUser = Parse.User.current()
			if currentUser.get('isSetUp') == true
				console.log 'user already set up'
				#nothing needs to happen
				return
			#set up the user
			console.log 'still here'
			@setUpSafety()
			#set it to true so the set up doesn't happen again
			currentUser.set
				isSetUp: true
			currentUser.save()
		
		setUpSafety: ->
			console.log 'setting up safety'
			
			list = new StepList
			
			#add all the steps to the list
			stepJSON = [{"step_num":1,"title":"Warning Signs","description":"Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:","fields":["warning sign"]},{"step_num":2,"title":"Coping Strategies","description":"Internal coping strategies: things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):","fields":["coping strategy"]},{"step_num":3,"title":"People","description":"People that provide distraction:","fields":["name","phone number"]},{"step_num":4,"title":"Settings","description":"Social settings that provide distraction:","fields":["place"]}]
			list.add stepJSON
			
			currentUser = Parse.User.current();
			
			#loop through each step
			for st in list.models
				#make it query-able by that user
				st.set
					user: currentUser
				#make sure only cur user can get it
				st.setACL(new Parse.ACL(currentUser))
				#save it
				st.save()
			
		setUpDevice: ->
			#window.localStorage["init"] = 'false' #temporary
			
			#console.log JSON.parse window.localStorage["steplist"]
			#console.log 'init?', window.localStorage["init"]
			if window.localStorage["init"] == 'true'
				console.log 'device already set up'
				return
			#otherwise there isn't the necessary stuff in localstorage
			#EVERYTHING in parse (even the stuff that has been uploaded)
			#should still be in localstorage
			#and when it can, it is also uploaded to parse
			#but not deleted from local storage

			#user MUST be online if they've never used the device before
			else if window.uploader.mode != "online"
				console.log "sorry, you must be online to set up the device"
				return
			
			else
				#get everything from parse and put it in localstorage
				#meaning, the step variables

				#duplicate code....
				currentUser = Parse.User.current()
				
				console.log 'about to query'
				query = new Parse.Query Step
				#get all of the steps that are linked to the current user
				query.equalTo "user", currentUser
				query.find
					success: (results) ->
						console.log 'success in query'
						list = new StepList
						#fill up the step list
						for r in results
							list.add r
						#end of duplicate code...
						window.localStorage["steplist"] = JSON.stringify(list)
						console.log window.localStorage["steplist"]
					error: (e) ->
						console.log 'error', e
			
				console.log 'steplist in locstor', JSON.parse window.localStorage["steplist"]

				window.localStorage["init"] = true
				
				
				