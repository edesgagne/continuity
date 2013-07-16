define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/activitiestemplate.html'], 
($, Mobile, _, Parse, activitiestemplate) ->
	class ActivitiesView extends Parse.View
		el: '[data-role="content"]'
		template: _.template activitiestemplate
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			$(@el).html @template