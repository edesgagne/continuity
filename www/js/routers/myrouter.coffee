define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'views/stepview', 'views/steplistview'], 
($, Mobile, _, Parse, Step, StepList, StepView, StepListView) ->
	class window.MyRouter extends Parse.Router
		initialize: ->
			console.log "router"
		routes:
			"": "showHome"
			"safety": "showSafety"
		showHome: ->
			title = "Home"

			#log
			console.log "show " + title
			
			#clear everything
			$('[data-role="content"]').html title + " page"
			
			#change header
			$('[data-role="header"] > h3').html title
		showSafety: ->
			title = "Safety Planning"
			
			#log
			console.log "show " + title
			
			#clear everything
			$('[data-role="content"]').html """
			"""
			
			#change header
			$('[data-role="header"] > h3').html title
			
			#change content
			list = new StepList
			
			stepJSON = [
			    {
			        "step_num": 1,
			        "title": "Warning Signs",
			        "description": "Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:",
			        "fields": [
			            "warning sign"
			        ]
			    },
			    {
			        "step_num": 2,
			        "title": "Coping Strategies",
			        "description": "Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):",
			        "fields": [
			            "coping strategy"
			        ]
			    },
			    {
			        "step_num": 3,
			        "title": "People",
			        "description": "People that provide distraction:",
			        "fields": [
			            "name",
			            "phone number"
			        ]
			    },
			    {
			        "step_num": 4,
			        "title": "Settings",
			        "description": "Social settings that provide distraction:",
			        "fields": [
			            "place"
			        ]
			    }
			]
			
			#$.getJSON "js/json/steps.json", (data) ->
			#	console.log 'json', data
			
			list.add stepJSON
	
			#loop through each model
			for st in list.models
				#set it to the current user
				
				#save it
				st.save()
			
			listview = new StepListView {collection: list}
						
			element = listview.el
			
			$('[data-role="content"]').html element

			#initialize everything to make it styled with jquery mobile
			$('[data-role="content"] > div').collapsibleset()
			$('.textinput').textinput();
			$('[type="submit"]').button();