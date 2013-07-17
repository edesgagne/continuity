define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview'], 
($, Mobile, _, Parse, StepList, StepListView) ->
	class SafetyView extends Parse.View
		el: '[data-role="content"]'
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			list = new StepList
			steps_array = JSON.parse window.localStorage["steplist"]
			for step in steps_array
				list.add step
			listview = new StepListView {collection: list}

			#display it
			$(@el).html listview.render().el
			listview.jqdisplay()
			
			$(@el).append """
			
			<span style="font-size: 12px; margin-top: 10px">
			Adapted from the Safety Plan Template developed by Barbara Stanley and Gregory K. Brown
			<span>
			
			"""
