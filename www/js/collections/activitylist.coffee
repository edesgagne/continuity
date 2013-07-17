define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/activity'], ($, Mobile, _, Parse, Activity) ->
	class ActivityList extends Parse.Collection
		model: Activity
		comparator: (object) ->
			return object.get('id')