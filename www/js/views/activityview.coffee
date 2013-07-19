define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/activitytemplate.html'], 
($, Mobile, _, Parse, activitytemplate) ->
	class ActivityView extends Parse.View
		template: _.template activitytemplate
		tagName: 'div'
		events:
			'click #unchecked': 'checked'
		initialize: ->
			_.bindAll @, 'render', 'checked'
			@model.on 'change:isCompleted', @makeChecked, @
		render: ->
			$(@el).empty()
			
			$(@el).html @template(@model.toJSON())
			@ #return itself
		checked: ->
			console.log 'checked'
			@model.complete()
		close: ->
			@model.unbind 'change:isCompleted', @makeChecked
			#for all backbone views
			$(@el).empty()
			
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
			
			delete this
		makeChecked: ->
			console.log 'making checked'
			@render()