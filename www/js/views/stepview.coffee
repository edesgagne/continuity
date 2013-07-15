define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class StepView extends Parse.View
		main_template: _.template """
		<h3>
		<%= step_num %> : <%= title %>
		</h3>
	

	<div style="opacity:0.5; text-shadow: none; font-size: 14px; color: #333; background-color: pink; padding: 10px; border-radius: 10px"> 
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
		
		
		"""
		sub_template: _.template """
		<!--display old strategies -->
			<% if (strategies.length != 0) { %>
			
		<ol style="list-style-type: none; text-shadow: none; border:5px solid gray; padding: 10px; padding-left: 30px; border-radius: 10px">
		<% i = 0 %>
		<% _.each(strategies, function(strat) { %> 
			<li id="<%= i %>" style="font-size: 16px; padding: 10px">
				<a class="delete" style="margin-right: 10px;" href="#" data-bypass="true" data-iconpos="notext" data-role="button" data-icon="delete" data-mini="true" data-inline="true">Delete</a>
				
				<% if(strat.indexOf("|") == -1) { %>
					<%= strat %>
				<% } else { %>
					<% arr = strat.split(" | ");
					str = arr[0];
					phone = arr[1];
					%>
					<%= str %>
					
					<a data-inline="true" data-mini="true" data-role="button" href="tel:<%= phone %>">
					Call Phone: <%= phone %>
					</a>
					
					
				<% } %>
			</li> 
			<% i = i + 1 %>
		
		<% }); %>
		</ol>
		
		<% } %>
		"""
		
		tagName: 'div'
		attributes:
			'data-role': 'collapsible'
			'data-collapsed': 'true'
		events:
			"click .submit": "add"
			"click .delete": "remove"
			
		initialize: ->
			_.bindAll @, 'render', 'add', 'remove'
			
			id = @model.get('step_num')
			#console.log id
			$(@el).attr('id', id)
			
			#always stays the same
			@content = @main_template(@model.toJSON())
		render: ->
			sub_content = @sub_template(@model.toJSON())
			$(@el).html @content
			$(@el).append sub_content
			@ #return itself
		#updateStrategies: (changedmodel) ->
		#	console.log 'update strategies view'
		#	console.log changedmodel
		#	@render()
		remove: (e) ->
			e.preventDefault()
			
			#get the id of the list element
			todelete =  $(e.currentTarget).parent()
			id = todelete.attr('id') #ex: list_0
			num = parseInt(id) #ex: 0
			
			#remove it from the model
			#so it doesn't get rerendered wrong
			arr = @model.get('strategies')
			#remove the element at index 'num'
			arr.splice(num, 1) #only remove 1 element
			
			@model.set
				strategies: arr
			
			console.log 'updated strategies', @model.get('strategies')
			
			#then the collection will rerender it
			
			#remoe it from localstorage and parse using uplaoder
		add: (e) ->
			e.preventDefault()
						
			#get values of input fields
			output = Array()
			$(@el).find('.textinput').each ->
				output.push $(this).val()
				#clear it
				$(this).val("")
			str_output = output.toString()
			
			str_output = str_output.replace(","," | ")
			
			#add them to the array
			@model.get('strategies').push str_output
			@model.trigger('change', @model)
			
			#JUST THAT UPDATES TEH MODEL!!
						
			#update the model
			#@model.set
			#	strategies: arr
			
			#then the collection will re render it
			console.log 'added strategies', @model.get('strategies')