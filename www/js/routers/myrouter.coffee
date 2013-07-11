define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step', 'collections/steplist', 'views/stepview', 'views/steplistview'], 
($, Mobile, _, Parse, Step, StepList, StepView, StepListView) ->
	class MyRouter extends Parse.Router
		
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
			"help": "showHelp"
		
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
			
			$('[data-role="content"]').html "You are logged in as <b>" + Parse.User.current().get("username") + "</b>"
			
		showSafety: ->
			title = "Safety Planning"
			@basics title
			
			#change content
			#list must be gotten in a query
			window.uploader.displaySteps()
			
		showHelp: ->
			title = "Get Help"
			@basics title
			
			

			
			
			$('[data-role="content"]').html """
			
			<a data-icon="grid" data-role="button" href="tel:8002738255">
			Call the Lifeline
			</a>
			
			<button
			onclick="window.open('http://suicidepreventionlifeline.org/GetHelp/LifelineChat.aspx', '_blank', 'location=yes');"
			target="_blank" data-icon="grid" data-role="button" href="">
			Lifeline Crisis Chat
			</button>
			
			
			<button
			onclick="window.open('http://findtreatment.samhsa.gov/MHTreatmentLocator/faces/quickSearch.jspx', '_blank', 'location=yes');"
			target="_blank" data-icon="search" data-role="button" href="">
			Treatment Locator
			</button>
			
			
			
			"""
			
			$('[data-role="button"]').button();
			
			