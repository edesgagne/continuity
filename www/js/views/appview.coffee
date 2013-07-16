define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/apptemplate.html'], 
($, Mobile, _, Parse, apptemplate) ->
	class AppView extends Parse.View
		el: '[data-role="page"]'
		template: _.template apptemplate
		events:
			'click .logout': 'logOut'
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @, 'logOut', 'render'
			@render()
			@jqdisplay()
						
			#one time, only when user signs up
			#uploads all the steps to parse.com
			#@setUpUser() 
			#each time user is on new device
			#re-set up local storate
			#puts all the steps from parse.com in localstorage
			#@setUpDevice() #has the query in it

		logOut: ->
			console.log 'logging out'
			Parse.User.logOut()
			window.location.reload()
		render: ->
			console.log 'app view'
			$(@el).html @template
		jqdisplay: ->
			$(@el).trigger("pagecreate")
		#	$(@el).ready ->
		#		$.mobile.changePage $('[data-role="page"]')

