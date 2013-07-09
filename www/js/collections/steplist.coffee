define ['jquery', 'jquerymobile', 'underscore', 'backbone', 'models/step'], ($, Mobile, _, Backbone, Step) ->
	class window.StepList extends Backbone.Collection
		model: Step