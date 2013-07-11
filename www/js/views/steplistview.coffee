define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/stepview'], ($, Mobile, _, Parse, StepView) ->
	class StepListView extends Parse.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @
			@collection.bind "change", @rerender, @
			@changed = -1
		render: ->
			@collection.each @renderEach, @
			@ #returns itself
		jqdisplay: ->
			console.log 'jq display'
			#initialize everything to make it styled with jquery mobile
			$('[data-role="collapsible-set"]').collapsibleset()

			$('.textinput').textinput();
			$('[type="submit"]').button();
			$('[data-role="button"]').button();
		rerender: (changedmodel)->
			console.log 'rerendering'
			$(@el).html("")
			

						
			#get the index of the model that was changed
			@collection.sort()
			@changed = null
			i = 1
			for model in @collection.models
				console.log model
				if model == changedmodel
					console.log 'SAME'
					@changed = i
					break
				i = i + 1
			
			console.log @changed
			
			#update local storage
			window.uploader.updateCollection @collection
			
			@render()
			console.log 'rerendering collection'
			
			@jqdisplay()
			
		renderEach: (step) ->
			console.log @changed, step.get('step_num')
			stepView = new StepView {model: step}
			element = stepView.render().el
			
			if @changed != -1 and @changed == step.get('step_num')
				#make it open
				$(element).attr('data-collapsed', 'false')
				#reset changed back to normal
				@changed = -1
			$(@el).append element
			
			
