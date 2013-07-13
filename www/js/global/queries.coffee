define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'routers/myrouter'], 
($, Mobile, _, Parse, Step, StepList, MyRouter) ->
	class Queries extends Parse.Object
		className: "Queries"
		initialize: ->	
			console.log "queries"
			
			_.bindAll @
			
		logInUser: (name, pass)->
			Parse.User.logIn name, pass,
				success: (user) ->
					console.log 'success logging in'
				error: (user, error) ->
					console.error 'error logging in', error
		
		signUpUser: (name, pass)->
			user = new Parse.User()
			user.set("username", name)
			user.set("password", pass)
			
			user.signUp null,
				success: (user) ->
					console.log 'success signing up'
				error: (user, error) ->
					console.error "error signing up " + error.code + " " + error.message
		
		saveAllObjects: (obj_arr)->
			console.log 'Queries: saving all objects'
			
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
			
			Parse.Object.saveAll(obj_arr)


		syncParseWithLocalStorage: ->
			#user MUST be online if they've never used the device before
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return

			if window.localStorage["init"] == Parse.User.current().get('username')
				console.log 'device already set up'

				return

			currentUser = Parse.User.current()


			query = new Parse.Query Step
			#get all of the steps that are linked to the current user
			query.equalTo "user", currentUser
			console.log 'setting up device...about to query'

			query.find
				success: (results) ->
					console.log 'success in query'
					list = new StepList
					#fill up the step list
					for r in results
						list.add r
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

				