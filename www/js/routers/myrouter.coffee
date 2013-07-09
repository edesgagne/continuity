#define ['lib/underscore', 'lib/backbone', 'jquery', 'models/step', 'collections/steplist', 'views/stepview'], (_, Backbone, $, Step, StepList, StepView) ->
define ['jquery', 'underscore', 'lib/backbone', 'models/step', 'collections/steplist', 'views/stepview'], ($, _, Backbone, Step, StepList, StepView) ->
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
			
			step = new Step
			list = new StepList
			stepview = new StepView model: step
			console.log stepview.render().el
		# 	#change content
		# 	@list = new StepList
		# 	@list.add new Step 
		# 		step_num: 1
		# 		title: 'Warning Signs'
		# 		description: 'Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:'
		# 		fields: ['warning sign']
		# 	@list.add new Step 
		# 		step_num: 2
		# 		title: 'Coping Strategies'
		# 		description: 'Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):'
		# 		fields: ['coping strategy']
		# 	@list.add new Step 
		# 		step_num: 3
		# 		title: 'People'
		# 		description: 'People that provide distraction:'
		# 		fields: ['name', 'phone number']
		# 	@list.add new Step 
		# 		step_num: 4
		# 		title: 'Settings'
		# 		description: 'Social settings that provide distraction:'
		# 		fields: ['place']
		# 		
		# 	@stepview = new StepView {model: new Step}
		# 	console.log @stepview.render().el
		# 	
		# 	#listview = new StepListView {collection: @list}
			