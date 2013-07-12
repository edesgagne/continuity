define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/beforestartview'], 
($, Mobile, _, Parse, BeforeStartView) ->
	class AppView extends Parse.View
		el: '[data-role="page"]'
		events:
			'click .logout': 'logOut'
		#used to get around require js circular dependencies
		#for login and app view
		initialize: ->
			_.bindAll @
			@render()
			@jqdisplay()
		logOut: ->
			console.log 'logging out'
			Parse.User.logOut()
			new BeforeStartView
		render: ->
			console.log 'app view'
			
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
		jqdisplay: ->
			$(@el).trigger("pagecreate")
			$(@el).ready ->
				$.mobile.changePage $('[data-role="page"]')
			
