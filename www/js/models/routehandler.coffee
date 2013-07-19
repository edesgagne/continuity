define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class RouteHandler extends Parse.Object
		showView: (view) ->
			if @currentView
				console.log 'closing the current view...', @currentView
				@currentView.close()
			console.log "next view", view
			@currentView = view
			@currentView.render()
			
			$('[data-role="content"]').html @currentView.el
			
			if @currentView.jqdisplay
				@currentView.jqdisplay()
