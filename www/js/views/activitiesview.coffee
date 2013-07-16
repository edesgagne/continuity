define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class ActivitiesView extends Parse.View
		el: '[data-role="content"]'
		template: _.template("Ready for activities?")
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			$(@el).html @template