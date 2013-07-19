define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/homeview', 'views/steplistview', 'views/helpview', 'views/activitylistview'], 
($, Mobile, _, Parse, HomeView, StepListView, HelpView, ActivityListView) ->
	class MyRouter extends Parse.Router
		
		routes:
			"": "showHome"
			"safety": "showSafety"
			"help": "showHelp"
			"activities": "showActivities"
		
		initialize: (routeHandler)->
			console.log "router"
			@routeHandler = routeHandler
			@bindMenu()
			
		bindMenu: ->
			#set it up so the links in the menu bar work
			$(document).on "click", "a:not([data-bypass])", (evt) ->
				
				href =
					prop: $(this).prop("href")
					attr: $(this).attr("href")
				
				
				root = location.protocol + "//" + location.host + "/"
				if href.prop and href.prop.slice(0, root.length) is root
					evt.preventDefault()
					Parse.history.navigate href.attr, {trigger: true}

				#close the panel
				$('#myPanel').panel("close")

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
			@routeHandler.showView(new HomeView)
		
		showActivities: ->
			title = "Activities"
			@basics title
			@routeHandler.showView(new ActivityListView)
		
		showSafety: ->
			title = "Safety Planning"
			@basics title
			@routeHandler.showView(new StepListView)
			
		showHelp: ->
			title = "Get Help"
			@basics title
			@routeHandler.showView(new HelpView)
			