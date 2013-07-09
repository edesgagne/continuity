define ['lib/underscore', 'lib/backbone', 'models/step'], (_, Backbone, Step) ->
	class window.StepList extends Backbone.Collection
		model: window.Step