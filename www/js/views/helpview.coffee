define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/helptemplate.html'], 
($, Mobile, _, Parse, helptemplate) ->
	class HelpView extends Parse.View
		el: '[data-role="content"]'
		template: _.template helptemplate
		initialize: ->
			_.bindAll @, 'render', 'jqdisplay'
			@render()
			@jqdisplay()
		render: ->
			$(@el).html @template
		jqdisplay: ->
			$('[data-role="button"]').button();