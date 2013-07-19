define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/stepview', 'collections/steplist'], ($, Mobile, _, Parse, StepView, StepList) ->
	class StepListView extends Parse.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			list = new StepList
			steps_array = JSON.parse window.localStorage["steplist"]
			for step in steps_array
				list.add step
			@collection = list
			
			_.bindAll @, 'render', 'rerender', 'jqdisplay', 'renderEach', 'close'
			@collection.on 'change', @rerender
			
			@subviews = []

		render: ->
			#if you already had subviews
			if @subviews.length > 0
				console.log 'removing old subviews'
				for view in @subviews
					view.close()
					
			@collection.each @renderEach, @
			$(@el).append """
			
			<span style="font-size: 12px; margin-top: 10px">
			Adapted from the Safety Plan Template developed by Barbara Stanley and Gregory K. Brown
			<span>
			
			"""
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
			
			@subviews.push stepView
			
			element = stepView.render().el
			$(@el).append element
			
		close: ->
			for view in @subviews
				console.log 'removing old subviews final'
				view.close()
				
			@collection.off 'change', @rerender
			
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
