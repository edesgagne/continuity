define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/hometemplate.html'], 
($, Mobile, _, Parse, hometemplate) ->
	class HomeView extends Parse.View
		el: '[data-role="content"]'
		template: _.template hometemplate
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			$(@el).html @template {user: window.localStorage["user"]}