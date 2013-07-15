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



# displaySteps: ->
# 	if @mode == "offline" or @mode == "online"
# 		#always displays from localstorage
# 		#because its the most up to date
# 		console.log 'displaying offline'
# 		list = new StepList
# 		steps_array = JSON.parse window.localStorage["steplist"]
# 		for step in steps_array
# 			list.add step
# 		listview = new StepListView {collection: list}
# 	
# 		#display it
# 		element = listview.render().el
# 		$('[data-role="content"]').html element
# 		listview.jqdisplay()
# 	else
# 		console.error 'must be either online or offline'