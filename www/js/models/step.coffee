define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class Step extends Parse.Object
		className: "Step"
		defaults:
			step_num: 0
			title: ''
			description: ''
			fields: []
			strategies: []
		# toJSON: ->
		# 	{
		# 		"step_num": @get('stepnum'),
		# 		"strategies": @get('strategies')
		# 	}