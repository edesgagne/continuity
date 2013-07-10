define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.StepListView extends Parse.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @
			@collection.bind "change", @rerender, @
		render: ->
			@collection.each @renderEach, @
			@ #returns itself
		jqdisplay: ->
			console.log 'jq display'
			#initialize everything to make it styled with jquery mobile
			$('[data-role="collapsible-set"]').collapsibleset()

			$('.textinput').textinput();
			$('[type="submit"]').button();
		rerender: (changedmodel)->
			
			$(@el).html("")
			
			@render()
			console.log 'rerendering collection'
			
			@jqdisplay()
			
			console.log changedmodel
			
			changedmodel.trigger('openCollapsible')
			
			
		renderEach: (step) ->
			stepView = new window.StepView {model: step}
			element = stepView.render().el
			$(@el).append element
