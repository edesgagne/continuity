define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/activityview'], ($, Mobile, _, Parse, ActivityView) ->
	class ActivityListView extends Parse.View
		el: '[data-role="content"]'
		initialize: ->
			_.bindAll @, 'render'
			@collection.on 'change', @rerender
		render: ->
	
			
