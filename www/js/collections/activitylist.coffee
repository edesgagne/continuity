define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/activity'], ($, Mobile, _, Parse, Activity) ->
	class ActivityList extends Parse.Collection
		model: Activity
		comparator: (object) ->
			return object.id
		initialize: (json) ->
			@add json
			_.bindAll @
			@bind 'change:isCompleted', @completed, @
		completed: (completedModel) ->
			doneid = completedModel.id
			#see if it's the last one
			if doneid == @models.length
				@finishedList()
			#set the next one to unlocked and current
			else
				next = @get(doneid + 1)
				next.unlock()
				next.current()
		finishedList: ->
			console.log 'finished'