define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class HomeView extends Parse.View
		el: '[data-role="content"]'
		template: _.template("You are logged in as <b>" + window.localStorage["init"]  + "</b>")
		initialize: ->
			_.bindAll @
			@render()
		render: ->
			$(@el).html @template