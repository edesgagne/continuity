$ ->
	console.log "ready"
	
	class window.MyRouter extends Backbone.Router
		routes:
			"": "index"
			"steps": "showSteps"
	
		index: ->
			console.log "Index route has been called..."
	
		showSteps: ->
			
			console.log "show steps"
			@list = new StepList
			@list.add new Step 
				title: 'Step 1: Warning Signs'
				description: 'Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:'
			@list.add new Step 
				title: 'Step 2: Coping Strategies'
				description: 'Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):'
			@list.add new Step 
				title: 'Step 3: People & Settings'
				description: 'People and social settings that provide distraction:'
			@listview = new StepListView {collection: @list}
			
			

			element = @listview.render().el
			
			
			$('#step_display').html element

			#initialize it
			$('#step_display > div').collapsibleset()

			#refresh it
			#$('#step_display > div').collapsibleset("refresh")
			
			#display text input
			$('input').textinput();

	
	class window.StepListView extends Backbone.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @
			@render
		render: ->
			#console.log @collection
			@collection.each @renderEach, @
			@
		renderEach: (step) ->
			stepView = new window.StepView {model: step}
			element = stepView.render().el
			#console.log "render", element
			$(@el).append element
			#console.log "el", $(@el).html()

	class window.StepList extends Backbone.Collection
		model: window.Step
		#parse: ->


	class window.StepView extends Backbone.View
		tagName: 'div'
		attributes:
			'data-role': 'collapsible'
			'data-collapsed': 'true'
		initialize: ->
			_.bindAll @
			temp = """

			<h3>
			<%= title %> 
			</h3>

			<div> <i> <%= description %> </i> </div>


			<!-- add new strategy -->

				<input name="" class="textinput" placeholder="Add New" value="" type="text" data-mini="true">
				<input type="submit" value="Submit">


			<!--display old strategies -->
			<% _.each(strategies, function(strat) { %> <li><%= strat %></li> <% }); %>


			"""
			@template = _.template temp


		render: =>
			content = @template(@model.toJSON())
			$(@el).html content
			@ #return itself

	class window.Step extends Backbone.Model
		defaults:
			title: 'Step 0'
			description: 'Write some strategies.'
			strategies: []

	new MyRouter
	Backbone.history.start()
