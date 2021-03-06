define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/steptemplate.html'], 
($, Mobile, _, Parse, steptemplate) ->
	class StepView extends Parse.View
		template: _.template steptemplate
		tagName: 'div'
		attributes:
			'data-role': 'collapsible'
			'data-collapsed': 'true'
		events:
			"click .submit": "add"
			"click .delete": "del"
			
		initialize: ->
			_.bindAll @, 'render', 'add', 'del'
			$(@el).attr('id', @model.get('step_num'))
			
		render: ->
			$(@el).html @template(@model.toJSON())
			@ #return itself
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

			#then the collection will re render it
			console.log 'added strategies', @model.get('strategies')
		del: (e) ->
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
			
			#remove it from localstorage and parse using uplaoder
		close: ->
			#for all backbone views
			$(@el).empty()
			
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
			
			delete this