define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/activitytemplate.html'], 
($, Mobile, _, Parse, activitytemplate) ->
	class ActivityView extends Parse.View
		template: _.template activitytemplate
		tagName: 'div'
		events:
			'click #unchecked': 'checked'
		initialize: ->
			_.bindAll @, 'render', 'checked'
		render: ->
			$(@el).html @template(@model.toJSON())
			@ #return itself
		checked: ->
			console.log 'checked'
			@model.complete()
		close: ->
			#for all backbone views
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
