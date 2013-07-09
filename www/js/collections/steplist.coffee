define ['jquery', 'jquerymobile', 'underscore', 'backbone'], ($, Mobile, _, Backbone) ->
	class window.StepList extends Backbone.Collection
		model: Step