#define ['lib/backbone', 'jquery', 'routers/myrouter'], (Backbone, $, MyRouter) ->
define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist'], ($, Mobile, _, Parse, Step, StepList) ->
	class App extends Parse.Object
		className: "App"
		initialize: ->	
			#window.localStorage.clear() #temporary
			@bindEvents()
			
			console.log "app"
			#one time, only when user signs up
			#uploads all the steps to parse.com
			@setUpUser() 
			#each time user is on new device
			#re-set up local storate
			#puts all the steps from parse.com in localstorage
			@setUpDevice() #has the query in it
			
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
			if window.uploader.getMode() != "online"
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
			#user MUST be online if they've never used the device before
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return
				
			uploader.syncParseWithLocalStorage()
				