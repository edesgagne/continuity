define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/activitytemplate.html'], 
($, Mobile, _, Parse, activitytemplate) ->
	class ActivityView extends Parse.View
		template: _.template activitytemplate
		tagName: 'div'
		events:
			'click #check': 'checked'
		initialize: ->
			_.bindAll @, 'render', 'checked'
			@render()
		render: ->
			$(@el).html @template(@model.toJSON())
			@ #return itself
		checked: ->
			console.log 'checked'
			@model.complete()
