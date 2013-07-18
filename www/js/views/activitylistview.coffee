define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/activityview', 'text!templates/activitylisttemplate.html'], 
($, Mobile, _, Parse, ActivityView, activitylisttemplate) ->
	class ActivityListView extends Parse.View
		el: '[data-role="content"]'
		template: _.template activitylisttemplate
		events:
			'click #prev': 'prev'
			'click #next': 'next'
			'swiperight #activity': 'prev'
			'swipeleft #activity': 'next'
		initialize: ->
			_.bindAll @, 'render', 'rerender', 'getCurrentId', 'getCurrent', 'prev', 'next', 'changeScreen', 'jqdisplay'
			@collection.on 'change:isCompleted', @rerender, @
			@render(true)
		getCurrentId: ->
			arr = @collection.pluck("isCurrent")
			curid = arr.indexOf(true) + 1 #because arrays are 0 based
			return curid
		getCurrent: ->
			curid = @getCurrentId()
			cur = @collection.get(curid)
			return cur
		render: (firstcall)->
			if firstcall
				#initialize viewpointer
				@viewpointer = @getCurrentId()
			@changeScreen()
			
		prev: ->
			#should only work if enabled (in case of swipe)
			if $('#prev').attr("disabled") == "disabled"
				return
			console.log 'prev'
			@viewpointer--
			@changeScreen()
			
		next: ->
			#should only work if enabled (in case of swipe)
			if $('#next').attr("disabled")
				return
			console.log 'next'
			@viewpointer++
			@changeScreen()
			
		changeScreen: ->
			#changes screen to where the viewpointer is
			newscreen = @collection.get(@viewpointer)
			console.log @viewpointer
			av = new ActivityView {model: newscreen}
			#append to actual view and add buttons
			$(@el).html @template()
			$(@el).append av.el
			
			@jqdisplay()
			
			#disables/enables buttons accordingly
			if @viewpointer == 1
				$('#prev').button("disable")
			if @viewpointer == @getCurrentId()
				#whatever is next is locked
				$('#next').button("disable")
			
		rerender: (changedmodel) ->
			console.log 'rerender activitylistview' #, changedmodel
			curid = @getCurrentId()

				
			cur = @collection.get(curid)
			next = @collection.get(curid + 1)
			#make it the current one
			cur.notCurrent()
			next.current()
			#render
			@changeScreen()
			# console.log curid, @collection.models.length
			# if curid == @collection.models.length
			# 	console.log 'finished list'
			# 	#still make the check green
			# 	@changeScreen(true)
			# else 
			# 	@changeScreen()
		jqdisplay: ->
			$('[data-role="button"]').button()
			
