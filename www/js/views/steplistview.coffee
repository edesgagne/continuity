define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.StepListView extends Parse.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @
			#@collection.bind "change", @rerender, @
			@render()
		render: ->
			@collection.each @renderEach, @
			@ #returns itself
		jqdisplay: ->
			console.log 'jq display'
			#initialize everything to make it styled with jquery mobile
			$('[data-role="content"] > div').collapsibleset()

			$('.textinput').textinput();
			$('[type="submit"]').button();
		rerender: ->
			console.log 'rerendering collection'
			
			
			$('[data-role="content"] > div').collapsibleset('refresh')
			$('[data-role="content"] > div').find('div[data-role=collapsible]').each (i) ->
				$(this).collapsible({refresh: true})
				console.log $(this)	
			
			$('[data-role="content"] > div').trigger("create")
			
			@jqdisplay()
			
		renderEach: (step) ->
			stepView = new window.StepView {model: step}
			element = stepView.el
			$(@el).append element
