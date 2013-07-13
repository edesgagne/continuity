define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist'], ($, Mobile, _, Parse, StepList) ->
	class UserSetup extends Parse.Object
		
		initialize: ->	
			@setUpUser()
		
		setUpUser: ->
			if window.uploader.getMode() != "online"
				console.log "sorry, you must be online to set up the user"
				return

			currentUser = Parse.User.current()

			if currentUser.get('isSetUp') == true
				console.log 'user already set up'
				#set up device (if needed: the check is in the method)
				#the uploader sets up the router
				window.uploader.syncParseWithLocalStorage()
				#immediately set up device
				#no need to add safety steps to parse.com
			else
				@setUpSafety()

		setUpSafety: ->
			console.log 'setting up safety'

			list = new StepList

			#add all the steps to the list
			stepJSON = [{"step_num":1,"title":"Warning Signs","description":"Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:","fields":["warning sign"]},{"step_num":2,"title":"Coping Strategies","description":"Internal coping strategies: things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):","fields":["coping strategy"]},{"step_num":3,"title":"People","description":"People that provide distraction:","fields":["name","phone number"]},{"step_num":4,"title":"Settings","description":"Social settings that provide distraction:","fields":["place"]}]
			list.add stepJSON

			currentUser = Parse.User.current();

			#loop through each step
			obj_arr = []
			for st in list.models
				#make it query-able by that user
				st.set
					user: currentUser
				#make sure only cur user can get it
				st.setACL(new Parse.ACL(currentUser))
				#save it
				obj_arr.push st

			Parse.Object.saveAll(obj_arr).then ( ->
				#set up device
				#the uploader sets up the router
				window.uploader.syncParseWithLocalStorage()
			), (error) ->
				console.error 'error saving objects', error
