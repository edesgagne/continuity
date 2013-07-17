define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class Activity extends Parse.Object
		className: "Activity"
		defaults:
			id: 0
			description: ""
			isCompleted: false
			isCurrent: false
			isLocked: true
		complete: ->
			@set
				isCompleted: true
			@set
				isCurrent: false
		undoComplete: ->
			@set
				isCompleted: false
		unlock: ->
			@set
				isLocked: false
		current: ->
			@set
				isCurrent: true