define ['jquery', 'jquerymobile', 'underscore', 'parse'], ($, Mobile, _, Parse) ->
	class Activity extends Parse.Object
		className: "Activity"
		defaults:
			id: 0
			description: ""
			isCompleted: false
			isCurrent: false
			isLocked: true
			