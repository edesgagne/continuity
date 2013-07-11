define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/loginview'], 
($, Mobile, _, Parse, LoginView) ->
	class AppView extends Parse.View
		#reaches out for the element already in index.html
		el: '[data-role="page"]'
		events:
			'click .logout': 'logOut'
		#appTemplate: _.template $('#app-template').html()
		initialize: ->
			console.log 'app view'
			_.bindAll @
			@render()
			@jqdisplay()

		render: ->
			$(@el).html """
			<!--panel -->
					    <div data-role="panel" id="myPanel" data-display="push">
				<ul data-role="listview" class="nav-search">
					<li><a href="#">Home</a></li>
					<li><a href="#activities">Activities</a></li>
					<li><a href="#safety">Safety Planning</a></li>
					<li><a href="#help">Get Help</a></li>
				</ul>
					    </div>


			<!--header -->
					    <div data-role="header" class="header" data-position="fixed" role="banner">
					        <h3>Every Day</h3>
					        <a href="#myPanel" data-icon="bars" data-iconpos="notext"></a>
							<a class="logout" data-bypass="true">Log Out</a>
					    </div>


			<!--content -->
					    <div data-role="content">
					    </div>
			
			"""
		logOut: ->
			console.log 'logging out'
			Parse.User.logOut()
			new LoginView()
			
		#$(@el).html @appTemplate
		#	@
		jqdisplay: ->
			$(@el).trigger("pagecreate")
			$(@el).ready ->
				$.mobile.changePage $('[data-role="page"]')