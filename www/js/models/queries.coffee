define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'routers/myrouter'], 
($, Mobile, _, Parse, Step, StepList, MyRouter) ->
	class Queries extends Parse.Object
		className: "Queries"
		initialize: ->	
			_.bindAll @
			console.log "queries"
			
		logInUser: (name, pass)->
			Parse.User.logIn name, pass,
				success: (user) ->
					console.log 'success logging in'
					window.location.reload()
				error: (user, error) ->
					console.error 'error logging in', error
		
		signUpUser: (name, pass)->
			Parse.User.signUp name, pass,
				success: (user) ->
					console.log 'success signing up'
					window.location.reload()
				error: (user, error) ->
					console.error "error signing up " + error.code + " " + error.message
		
		saveAllObjects: (obj_arr)->
			console.log 'queries: saving all objects'
			Parse.Object.saveAll(obj_arr)


		syncParseWithLocalStorage: ->
			#user MUST be online if they've never used the device before
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return

			if window.localStorage["init"] == Parse.User.current().get('username')
				console.log 'device already set up'

				router = new MyRouter
				Parse.history.start()

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

					router = new MyRouter
					Parse.history.start()

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

				
