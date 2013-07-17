define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class Activity extends Parse.Object
		className: "Activity"
		defaults:
			id: 0
			description: ""
			isCompleted: false
			isCurrent: false
		complete: ->
			@set
				isCompleted: true
				#is completed is what the collection binds to
				#so it must be called last
				#so all other changes can be updated first
		undoComplete: ->
			@set
				isCompleted: false
		notCurrent: ->
			@set
				isCurrent: false
		current: ->
			@set
				isCurrent: true