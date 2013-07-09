define ['lib/backbone', 'models/step'], (Backbone, Step) ->
	class window.StepList extends Backbone.Collection
		model: window.Step