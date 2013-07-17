define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/apptemplate.html'], 
($, Mobile, _, Parse, apptemplate) ->
	class AppView extends Parse.View
		el: '[data-role="page"]'
		template: _.template apptemplate
		events:
			'click .logout': 'logOut'
		initialize: ->
			_.bindAll @, 'logOut', 'render'
			@render()
			@jqdisplay()
		logOut: ->
			console.log 'logging out'
			Parse.User.logOut()
			window.location.reload()
		render: ->
			console.log 'app view'
			$(@el).html @template
		jqdisplay: ->
			$(@el).trigger("pagecreate")

