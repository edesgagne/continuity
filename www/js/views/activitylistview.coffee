define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/activityview'], ($, Mobile, _, Parse, ActivityView) ->
	class ActivityListView extends Parse.View
		el: '[data-role="content"]'
		initialize: ->
			_.bindAll @, 'render', 'rerender'
			@collection.on 'change:isCompleted', @rerender, @
			@render()
		getCurrentId: ->
			arr = @collection.pluck("isCurrent")
			nextid = arr.indexOf(true) + 1
			return nextid
		getCurrent: ->
			nextid = @getCurrentId()
			next = @collection.get(nextid)
			return next
		render: ->
			$(@el).html ""
			#shows iscurrent in center
			next = @getCurrent()
			av = new ActivityView {model: next}
			$(@el).append av.el
			#shows prev button
		rerender: (changedmodel) ->
			console.log 'rerender' #, changedmodel
			curid = @getCurrentId()
			console.log curid
			if curid == @collection.models.length
				console.log 'finished list'
				return
			else
				cur = @collection.get(curid)
				next = @collection.get(curid + 1)
				#make it the current one
				console.log @collection.pluck("isCurrent")
				cur.notCurrent()
				next.current()
				console.log @collection.pluck("isCurrent")
				@render()
