define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/activitylist', 'views/activitylistview'], 
($, Mobile, _, Parse, ActivityList, ActivityListView) ->
	class ActivitiesView extends Parse.View
		el: '[data-role="content"]'
		#template: _.template activitiestemplate
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			myjson = [
				{id: 3, description: "ho 3"},
				{id: 1, description: "hey 1", isCurrent: true},
				{id: 2, description: "hi 2"},
			]
			@al = new ActivityList myjson
			@alv = new ActivityListView {collection: @al}
			#$(@el).html @alv.el
			
			