define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class window.Step extends Parse.Object
		defaults:
			step_num: 0
			title: ''
			description: ''
			fields: []
			strategies: []
		# addStrategy: (output) ->
		# 	console.log output
		# 	dic = {}
		# 	#length of output and field should be same
		# 	#in the dictionary
		# 	#field will be the key
		# 	#and output will be the key value
		# 	i = 0
		# 	while i < output.length
		# 		console.log i
		# 		key = @get('fields')[i]
		# 		val = output[i]
		# 		dic[key] = val
		# 		i++
		# 	console.log dic
		# 	@get('strategies').push dic
		# 	console.log @get('strategies')