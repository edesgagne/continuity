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
			#log
			console.log "show home.."
			
			#clear everything
			$('[data-role="content"]').html """
				Home page.
			"""
			
			#change header
			$('[data-role="header"] > h3').html "Home"
		showSafety: ->
			#log
			console.log "show safety.."
			
			#clear everything
			$('[data-role="content"]').html """
				Safety page.
			"""
			
			#change header
			$('[data-role="header"] > h3').html "Safety"
			
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
						
			element = @listview.render().el
			
			
			$('[data-role="content"]').html element

			#initialize it
			$('[data-role="content"] > div').collapsibleset()

			#display text input
			$('.textinput').textinput();
			
			#display button
			$('[type="submit"]').button();