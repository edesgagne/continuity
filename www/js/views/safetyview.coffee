define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/steplist', 'views/steplistview'], 
($, Mobile, _, Parse, StepList, StepListView) ->
	class SafetyView extends Parse.View
		el: '[data-role="content"]'
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			list = new StepList
			steps_array = JSON.parse window.localStorage["steplist"]
			for step in steps_array
				list.add step
			listview = new StepListView {collection: list}

			#display it
			element = listview.render().el
			$(@el).html element
			listview.jqdisplay()
