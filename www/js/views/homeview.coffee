define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/hometemplate.html', 'views/popupview'], 
($, Mobile, _, Parse, hometemplate, PopupView) ->
	class HomeView extends Parse.View
		el: '[data-role="content"]'
		template: _.template hometemplate
		events:
			'click button': 'openPopup'
		initialize: ->
			_.bindAll @, 'render', 'openPopup'
			
			@popup = new PopupView
				text: "You've earned points!"
			
			@render()
		render: ->
			$(@el).html @template {user: window.localStorage["user"]}
		openPopup: ->
			console.log 'popup event bound'
			@popup.open()