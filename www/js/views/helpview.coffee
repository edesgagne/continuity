define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class HelpView extends Parse.View
		el: '[data-role="content"]'
		template: _.template """
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
		initialize: ->
			_.bindAll @
			@render()
			@jqdisplay()
		render: ->
			$(@el).html @template
		jqdisplay: ->
			$('[data-role="button"]').button();