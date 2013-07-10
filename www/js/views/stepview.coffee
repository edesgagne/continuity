define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.StepView extends Parse.View
	
		tagName: 'div'
		attributes:
			'data-role': 'collapsible'
			'data-collapsed': 'true'
		events:
			"click .submit": "clicked"
			
		initialize: ->
			_.bindAll @, 'clicked'
			
			#whenever the model changes, the view should re-render
			
			#@model.bind('change', @rerender)
			
			temp = """
		
			<h3>
			<%= step_num %> : <%= title %>
			</h3>
		
			<div style="font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px"> 
			<%= description %>
			</div>
		
		
			<!-- add new strategy -->
				
			<% _.each(fields, function(field) { %> 
			
			
				<% if (field == "phone number") { %>
				    <input type="tel" name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
			    
				<% } else { %>
				    <input name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
				
				<% } %>
		
			<% }); %>
			<input id="<%= step_num %>" class="submit" type="submit" value="Submit" />
		
		
		
		
			<!--display old strategies -->
			<ul>
			<% _.each(strategies, function(strat) { %> <li><%= strat %></li> <% }); %>
			</ul>
		
			"""
			@template = _.template temp
			
			@render()
		
		render: =>
			content = @template(@model.toJSON())
			$(@el).html content
			@ #return itself
		rerender: =>
			console.log 'rerendering view'
			@render()
		clicked: (e) =>
			e.preventDefault()
			
			#get values of input fields
			output = Array()
			$(@el).find('.textinput').each ->
				output.push $(this).val()
				#clear it
				$(this).val("")
			str_output = output.toString()
			
			#add them to the array
			before = @model.get('strategies')
			before.push str_output
			
			#update the model
			@model.set
				strategies: before
							
			console.log 'updated strategies', @model.get('strategies')