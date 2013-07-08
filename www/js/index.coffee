$ ->
	console.log "ready"
	
	class window.MyRouter extends Backbone.Router
		routes:
			"": "index"
			"steps": "showSteps"
	
		index: ->
			console.log "show index.."
<<<<<<< HEAD
			
			#clear everything
			$('[data-role="content"]').html """
=======
			$("#contentbar").html """
>>>>>>> parent of 45cfffa... added jquery menu (and side bonus: somehow the 15 errors went away...)
				Home page.
			"""
			
			#change header
			$('[data-role="header"] > h3').html "Home"
	
		showSteps: ->
<<<<<<< HEAD
			console.log "show steps"
			
			#clear everything
			$('[data-role="content"]').html """
=======
			$("#contentbar").html """
			<div id="step_display" data-role="content">

		    </div>
>>>>>>> parent of 45cfffa... added jquery menu (and side bonus: somehow the 15 errors went away...)
			"""
				
			#change header
			$('[data-role="header"] > h3').html "Steps"
			
			#change content		
			@list = new StepList
			@list.add new Step 
				title: 'Step 1: Warning Signs'
				description: 'Warning signs (thoughts, images, mood, situation, behavior) that a crisis may be developing:'
				fields: ['warning sign']
			@list.add new Step 
				title: 'Step 2: Coping Strategies'
				description: 'Internal coping strategies – things I can do to take my mind off my problems without contacting another person (relaxation technique, physical activity):'
				fields: ['coping strategy']
			@list.add new Step 
				title: 'Step 3: People'
				description: 'People that provide distraction:'
				fields: ['name', 'phone number']
			@list.add new Step 
				title: 'Step 4: Settings'
				description: 'Social settings that provide distraction:'
				fields: ['place']
			@listview = new StepListView {collection: @list}
			
			

			element = @listview.render().el
			
			
			$('#step_display').html element

			#initialize it
			$('#step_display > div').collapsibleset()

			#display text input
			$('.textinput').textinput()
			#$('.textinput').css('width', '50%')
			
			#display button
			$('[type="submit"]').button();
			

	
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

			<div style="font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px"> 
			<%= description %>
			</div>


			<!-- add new strategy -->
			<% _.each(fields, function(field) { %> 
				<input name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
			<% }); %>
				
			<input type="submit" value="Submit" />
			
			
			
			
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
			fields: []
			strategies: []
	
	#executed once, on start of program
	new MyRouter
	Backbone.history.start()
	$(document).on "click", "a:not([data-bypass])", (evt) ->
		href =
			prop: $(this).prop("href")
			attr: $(this).attr("href")

		root = location.protocol + "//" + location.host + "/"
		if href.prop and href.prop.slice(0, root.length) is root
			evt.preventDefault()
			Backbone.history.navigate href.attr, true

	
