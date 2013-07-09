define ['lib/backbone'], (Backbone) ->
	class window.Step extends Backbone.Model
		defaults:
			step_num: 0
			title: ''
			description: 'Write some strategies.'
			fields: []
			strategies: []