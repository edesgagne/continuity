define ['jquery', 'jquerymobile', 'underscore', 'backbone'], ($, Mobile, _, Backbone) ->
	class window.StepListView extends Backbone.View
		tagName: 'div'
		attributes: 
			'data-role': 'collapsible-set'
		initialize: ->
			_.bindAll @
			@render
		render: ->
			#console.log @collection
			@collection.each @renderEach, @
			@
		renderEach: (step) ->
			stepView = new window.StepView {model: step}
			element = stepView.render().el
			#console.log "render", element
			$(@el).append element
			#console.log "el", $(@el).html()