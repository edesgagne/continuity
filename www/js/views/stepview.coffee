define ['jquery', 'jquerymobile', 'underscore', 'backbone'], ($, Mobile, _, Backbone) ->
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