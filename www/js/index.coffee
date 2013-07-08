$ ->
	console.log "ready"
	
	class window.MyRouter extends Backbone.Router
		routes:
			"": "showHome"
			"safety": "showSafety"
	
		showHome: ->
			#log
			console.log "show index.."
			
			#clear everything
			$('[data-role="content"]').html """
				Home page.
			"""
			
			#change header
			$('[data-role="header"] > h3').html "Home"	
	
		showSafety: ->
			#log
			console.log "show steps"
			
			#clear everything
			$('[data-role="content"]').html """
			"""
					
			#change header
			$('[data-role="header"] > h3').html "Safety Planning"	
			
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
		events:
			"click .submit": "clicked"
		initialize: ->
			_.bindAll @
			temp = """

			<h3>
			<%= step_num %> : <%= title %>
			</h3>

			<div style="font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px"> 
			<%= description %>
			</div>


			<!-- add new strategy -->
			<% _.each(fields, function(field) { %> 
				<input name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
			<% }); %>

			<input id="<%= step_num %>" class="submit" type="submit" value="Submit" />




			<!--display old strategies -->
			<% _.each(strategies, function(strat) { %> <li><%= strat %></li> <% }); %>


			"""
			@template = _.template temp


		render: =>
			content = @template(@model.toJSON())
			$(@el).html content
			@ #return itself
		
		clicked: (e) =>
			e.preventDefault()
			output = []
			$(@el).find('.textinput').each ->
				output.push $(this).val()
			#@model.addStrategy output
			#console.log @model.get('strategies').toString()

	class window.Step extends Backbone.Model
		defaults:
			step_num: 0
			title: ''
			description: 'Write some strategies.'
			fields: []
			strategies: []
		# addStrategy: (output_array) ->
		# 	@save
		# 		strategies: @get('strategies').push output_array

	class window.App extends Backbone.Model
		initialize: ->	
			new MyRouter
			Backbone.history.start()
			@initMenu()
			
		initMenu: ->
			#whenever a link in the menu is clicked
			#it tells the backbone router to navigate there
			$(document).on "click", "a:not([data-bypass])", (evt) ->
				href =
					prop: $(this).prop("href")
					attr: $(this).attr("href")

				root = location.protocol + "//" + location.host + "/"
				if href.prop and href.prop.slice(0, root.length) is root
					evt.preventDefault()
					Backbone.history.navigate href.attr, true
		
				#close the panel
				$('#myPanel').panel("close")

	#app = new App