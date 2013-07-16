define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/stepview'], ($, Mobile, _, Parse, StepView) ->
	class StepListView extends Parse.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @, 'rerender', 'jqdisplay', 'renderEach'
			@collection.on 'change', @rerender
		render: ->
			@collection.each @renderEach, @
			#@collection.bind 'remove', @rerender
			@ #returns itself
		rerender: (changedmodel) ->
			
			console.log 'called rerender'
			
			$(@el).html ""
			@render()
			
			#open up the collapsible
			step_num = changedmodel.get("step_num")
			$("#" + step_num).attr('data-collapsed', 'false')
			
			@jqdisplay()
			
			window.queries.updateCollection @collection
		jqdisplay: ->
			console.log 'jq display of steplistview'
			#initialize everything to make it styled with jquery mobile
			$('[data-role="collapsible-set"]').collapsibleset()

			$('.textinput').textinput();
			$('[type="submit"]').button();
			$('[data-role="button"]').button();	
			
		renderEach: (step) ->
			stepView = new StepView {model: step}
			element = stepView.render().el
			$(@el).append element
			
			
