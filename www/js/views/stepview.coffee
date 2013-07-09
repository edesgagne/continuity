define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.StepView extends Parse.View
	
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
			
			
				<% if (field == "phone number") { %>
				    <input type="tel" name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
			    
				<% } else { %>
				    <input name="" class="textinput" placeholder="Add <%= field %>" value="" type="text" data-mini="false" />
				
				<% } %>
		
			<% }); %>
			<input id="<%= step_num %>" class="submit" type="submit" value="Submit" />
		
		
		
		
			<!--display old strategies -->
			<% _.each(strategies, function(strat) { %> <li><%= strat %></li> <% }); %>
		
		
			"""
			@template = _.template temp
			
			@render()
		
		render: =>
			content = @template(@model.toJSON())
			$(@el).html content
			@ #return itself
			
		clicked: (e) =>
			console.log 'id', @model.get('step_num')
			console.log 'strat', @model.get('strategies')
			#get an array of the values
			e.preventDefault()
			output = []
			$(@el).find('.textinput').each ->
				output.push $(this).val()
			# #add it to the model
			# dic = {}
			# #length of output and field should be same
			# #in the dictionary
			# #field will be the key
			# #and output will be the key value
			# i = 0
			# while i < output.length
			# 	key = @model.get('fields')[i]
			# 	val = output[i]
			# 	dic[key] = val
			# 	i++
			# console.log dic
			# @model.set
			# 	strategies: @model.get('strategies').push dic
			# console.log @model.get('strategies')
			
			
			
			