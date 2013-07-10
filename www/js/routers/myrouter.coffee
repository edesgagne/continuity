define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'views/stepview', 'views/steplistview'], 
($, Mobile, _, Parse, Step, StepList, StepView, StepListView) ->
	class window.MyRouter extends Parse.Router
		
		initialize: ->
			console.log "router"
			#set it up so the links in the menu bar work
			$(document).on "click", "a:not([data-bypass])", (evt) ->
				href =
					prop: $(this).prop("href")
					attr: $(this).attr("href")

				root = location.protocol + "//" + location.host + "/"
				if href.prop and href.prop.slice(0, root.length) is root
					evt.preventDefault()
					Parse.history.navigate href.attr, true

				#close the panel
				$('#myPanel').panel("close")
		
		routes:
			"": "showHome"
			"safety": "showSafety"
		
		basics: (title) ->
			#log
			console.log "show " + title
			
			#clear everything
			$('[data-role="content"]').html title + " page"
			
			#change header
			$('[data-role="header"] > h3').html title
		
		showHome: ->
			title = "Home"
			@basics title
			
		showSafety: ->
			title = "Safety Planning"
			@basics title
			
			#change content
			#list must be gotten in a query
			
			currentUser = Parse.User.current()
			
			query = new Parse.Query Step
			#get all of the steps that are linked to the current user
			query.equalTo "user", currentUser
			query.find
				success: (results) ->
					list = new StepList
					#fill up the step list
					for r in results
						list.add r
					
					#sort the step list using "comparator" method in steplist
					list.sort()
					#create a view for the steplist
					listview = new StepListView {collection: list}
					
					#display it
					element = listview.render().el
					$('[data-role="content"]').html element
					listview.jqdisplay()