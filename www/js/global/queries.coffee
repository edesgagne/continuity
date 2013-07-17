define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/mysteps', 'views/popupview'], 
($, Mobile, _, Parse, MySteps, PopupView) ->
	class Queries extends Parse.Object
		#THESE ALL MUST RETURN PROMISES
		#CAN'T EVEN RETURN PARSE ERROR
		className: "Queries"
		initialize: ->	
			console.log "queries"
			_.bindAll @
		logInUser: (name, pass)->
			#it isn't returning the parse promise anyways
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return Parse.Promise.error({message: 'not online'})
			
			return Parse.User.logIn name, pass

		signUpUser: (name, pass)->
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return Parse.Promise.error("not online")
			
			user = new Parse.User()
			user.set("username", name)
			user.set("password", pass)
			
			return user.signUp null
		
		saveSteps: ->
			console.log 'saving steps'
			
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return Parse.Promise.error("not online")
						
			#add all the steps to the list
			stepJSON = [{"step_num":1,"title":"Warning Signs","description":"Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:","fields":["warning sign"],"strategies":[]},{"step_num":2,"title":"Coping Strategies","description":"Internal coping strategies: things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):","fields":["coping strategy"],"strategies":[]},{"step_num":3,"title":"People","description":"People that provide distraction:","fields":["name","phone number"],"strategies":[]},{"step_num":4,"title":"Settings","description":"Social settings that provide distraction:","fields":["place"],"strategies":[]},{"step_num":5,"title":"Professionals","description":"Professionals or agencies I can contact during a crisis:","fields":["name","phone number"],"strategies":[]},{"step_num":6,"title":"Environment","description":"Ways to make the environment safe:","fields":["way"],"strategies":[]},{"step_num":7,"title":"One Thing","description":"The one thing that is most important to me and worth living for is:","fields":["thing"],"strategies":[]}]
			#save user to localstorage
			window.localStorage["user"] = Parse.User.current().get("username")
			
			#save steps to localstorage
			window.localStorage["steplist"] = JSON.stringify(stepJSON)
			
			#save steps to parse
			currentUser = Parse.User.current();
			
			b = new MySteps {list: JSON.stringify(stepJSON)}
			b.set
				user: currentUser
			b.setACL(new Parse.ACL(currentUser))
			
			console.log 'mysteps: ', b
			b.save()
	
		parseToLocalStorage: ->
			console.log 'parse to localstorage'
			#user MUST be online if they've never used the device before
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return Parse.Promise.error("not online")
			if window.localStorage["user"] == Parse.User.current().get('username')
				console.log 'local storage already contains this user data'
				return Parse.Promise.as("already set up")
				#set parse steps to localstorage
			
			currentUser = Parse.User.current()
			
			query = new Parse.Query MySteps
			query.equalTo "user", currentUser
			return query.first
				success: (mysteps) ->
					console.log 'success in query'
					myjson = JSON.parse mysteps.get("list")
					window.localStorage["steplist"] = JSON.stringify(myjson)
					window.localStorage["user"] = currentUser.get("username")
	
		updateCollection: (coll) ->
			#update collection to localstorage
			console.log 'updating collection on localstorage'

			window.localStorage["steplist"] = JSON.stringify coll

			#upload to parse if mode is online
			#it won't work to reply on updateMode
			#because if you're always online
			#nothing gets refreshed and uploaded
			if window.uploader.getMode() == "online"
				#can immediately be uploaded online
				window.queries.updateCollectionOnline()	
			else
				#must upload offline updates eventually
				window.uploader.setUpdatedOffline(true)
		updateCollectionOnline: ->
			console.log 'updating collection online'
				
			if window.uploader.getMode() != "online"
				console.error "sorry, you must be online to set up the device"
				return Parse.Promise.error("not online")
			
			#upload everything to parse
			query = new Parse.Query MySteps
			#get all of the steps that are linked to the current user
			currentUser = Parse.User.current()
			query.equalTo "user", currentUser
			#query.ascending('step_num')
			return query.first
				success: (mysteps) ->
					steps = window.localStorage["steplist"]
					mysteps.set
						list: steps
					#console.log mysteps
					mysteps.save()
					console.log 'synced online'