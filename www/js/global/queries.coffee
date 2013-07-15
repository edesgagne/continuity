define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'routers/myrouter', 'models/mysteps'], 
($, Mobile, _, Parse, Step, StepList, MyRouter, MySteps) ->
	class Queries extends Parse.Object
		#THESE ALL MUST RETURN PROMISES
		#CAN'T EVEN RETURN PARSE ERROR
		className: "Queries"
		initialize: ->	
			console.log "queries"
			
			_.bindAll @
			
		logInUser: (name, pass)->
			return Parse.User.logIn name, pass,
				# success: (user) ->
				# 	console.log 'success in login'
				# 	return Parse.Promise.as()
				# error: (user, error) ->
				# 	console.log 'error in login'
				# 	return Parse.Promise.error(error)
		
		signUpUser: (name, pass)->
			user = new Parse.User()
			user.set("username", name)
			user.set("password", pass)
			
			return user.signUp null,
				success: (user) ->
					console.log 'success signing up'
				error: (user, error) ->
					console.error "error signing up " + error.code + " " + error.message
		
		saveAllObjects: ->
			console.log 'Queries: saving all objects'
			

			
			mylist = new StepList

			#add all the steps to the list
			stepJSON = [{"step_num":1,"title":"Warning Signs","description":"Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:","fields":["warning sign"]},{"step_num":2,"title":"Coping Strategies","description":"Internal coping strategies: things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):","fields":["coping strategy"]},{"step_num":3,"title":"People","description":"People that provide distraction:","fields":["name","phone number"]},{"step_num":4,"title":"Settings","description":"Social settings that provide distraction:","fields":["place"]}]
			mylist.add stepJSON

			currentUser = Parse.User.current();
			
			b = new MySteps {list: JSON.stringify(mylist)}
			b.set
				user: currentUser
			b.setACL(new Parse.ACL(currentUser))
			
			console.log 'mysteps: ', b
			b.save()

			# #loop through each step
			# obj_arr = []
			# for st in mylist.models
			# 	#make it query-able by that user
			# 	st.set
			# 		user: currentUser
			# 	#make sure only cur user can get it
			# 	st.setACL(new Parse.ACL(currentUser))
			# 	#save it
			# 	obj_arr.push st
			# 
			# return Parse.Object.saveAll(obj_arr)
			

		syncParseWithLocalStorage: ->

			#user MUST be online if they've never used the device before
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				fail = new Parse.Promise()
				return fail.reject "not online"

			if window.localStorage["init"] == Parse.User.current().get('username')
				console.log 'device already set up'
				success = new Parse.Promise()
				return success.resolve()

			currentUser = Parse.User.current()


			query = new Parse.Query MySteps
			#get all of the steps that are linked to the current user
			query.equalTo "user", currentUser
			console.log 'setting up device...about to query'

			return query.first
				success: (mysteps) ->
					console.log 'success in query'
										
					list = new StepList
					
					#fill up the step list
					myjson = JSON.parse(mysteps.get("list"))
					list.add myjson
					
					console.log list
					window.localStorage["steplist"] = JSON.stringify(list)
					console.log 'locstor', window.localStorage["steplist"]

					#can let the rest of the program continue
					#@updateBlocker false

					console.log 'setting is set up to true'
					currentUser.set
						isSetUp: true
					currentUser.save()

					

					console.log 'done in sync parse with local storage'
					
					window.localStorage["init"] = Parse.User.current().get('username')
				
				error: (e) ->
					console.error 'error', e
					
		updateCollectionOnline: ->	

			#upload everything to parse
			query = new Parse.Query MySteps
			#get all of the steps that are linked to the current user
			currentUser = Parse.User.current()
			query.equalTo "user", currentUser
			#query.ascending('step_num')
			return query.first
				success: (mysteps) ->
					steps = JSON.stringify(JSON.parse(window.localStorage["steplist"]))
					mysteps.set
						list: steps
					console.log mysteps
					mysteps.save()
					console.log 'synced online'
				error: (e) ->
					console.error 'error', e

				
