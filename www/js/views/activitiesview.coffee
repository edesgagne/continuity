define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/activity', 'views/activityview', 'text!templates/activitiestemplate.html'], 
($, Mobile, _, Parse, Activity, ActivityView, activitiestemplate) ->
	class ActivitiesView extends Parse.View
		el: '[data-role="content"]'
		#template: _.template activitiestemplate
		initialize: ->
			_.bindAll @, 'render'
			@render()
		render: ->
			#$(@el).html @template
			# a = new Activity({id: 1, description: "activity desc"})
			# v = new ActivityView {model: a}
			$(@el).html 'hello'
			