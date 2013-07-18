define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/activitylist', 'views/activitylistview'], 
($, Mobile, _, Parse, ActivityList, ActivityListView) ->
	class ActivitiesView extends Parse.View
		el: '[data-role="content"]'
		#template: _.template activitiestemplate
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			myjson = window.queries.getMyJSON("js/json/activities.json")
			console.log myjson
			@al = new ActivityList myjson
			@alv = new ActivityListView {collection: @al}
			#$(@el).html @alv.el
			
			