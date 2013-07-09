#define ['lib/underscore', 'lib/backbone', 'jquery', 'models/step', 'collections/steplist', 'views/stepview'], (_, Backbone, $, Step, StepList, StepView) ->
define ['jquery', 'jquerymobile', 'underscore', 'backbone', 'models/step', 'collections/steplist', 'views/stepview', 'views/steplistview'], 
($, Mobile, _, Backbone, Step, StepList, StepView, StepListView) ->
	class window.MyRouter extends Backbone.Router
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
			@list = new StepList
			
			@list.add new Step 
				step_num: 1
				title: 'Warning Signs'
				description: 'Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:'
				fields: ['warning sign']
			@list.add new Step 
				step_num: 2
				title: 'Coping Strategies'
				description: 'Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):'
				fields: ['coping strategy']
			@list.add new Step 
				step_num: 3
				title: 'People'
				description: 'People that provide distraction:'
				fields: ['name', 'phone number']
			@list.add new Step 
				step_num: 4
				title: 'Settings'
				description: 'Social settings that provide distraction:'
				fields: ['place']
						
			@listview = new StepListView {collection: @list}
						
			element = @listview.el
			
			$('[data-role="content"]').html element

			#initialize everything to make it styled with jquery mobile
			$('[data-role="content"] > div').collapsibleset()
			$('.textinput').textinput();
			$('[type="submit"]').button();