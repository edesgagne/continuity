define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/mysteps', 'views/popupview'], 
($, Mobile, _, Parse, MySteps, PopupView) ->
	class Queries extends Parse.Object
		#THESE ALL MUST RETURN PROMISES
		#CAN'T EVEN RETURN PARSE ERROR
		className: "Queries"
		initialize: ->	
			console.log "queries"
			_.bindAll @
		getMyJSON: (file)->
			#asynchronous
			#exception: doesn't actually return a parse promise
			console.log 'calling get json'
			myjson = null
			$.ajax
				url: file
				async: false
				dataType: 'json'
				success: (json) ->
					myjson = JSON.stringify(json)
			return JSON.parse myjson
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
			stepJSON = @getMyJSON("js/json/steps.json")
			
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