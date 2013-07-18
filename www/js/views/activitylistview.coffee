define ['jquery', 'jquerymobile', 'underscore', 'parse', 'views/activityview', 'text!templates/activitylisttemplate.html'], 
($, Mobile, _, Parse, ActivityView, activitylisttemplate) ->
	class ActivityListView extends Parse.View
		el: '[data-role="content"]'
		template: _.template activitylisttemplate
		events:
			'click #prev': 'prev'
			'click #next': 'next'
			#'swiperight window': 'prev'
			#'swipeleft window': 'next'
		initialize: ->
			_.bindAll @, 'render', 'rerender', 'getCurrentId', 'getCurrent', 'prev', 'next', 'changeScreen', 'jqdisplay', 'remove'
			@collection.on 'change:isCompleted', @rerender, @
			@render(true)
			$(window).bind "swiperight", _.bind(@prev, @)
			$(window).bind "swipeleft", _.bind(@next, @)
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
				console.error 'tried to call prev, but disabled'
				#probably not necessary for prev
				#alert("Sorry, there is no previous activity")
				return
			console.log 'prev'
			@viewpointer--
			@changeScreen()
			
		next: ->
			#should only work if enabled (in case of swipe)
			if $('#next').attr("disabled")
				console.error 'tried to call next, but disabled'
				alert("Sorry, you must tap the checkmark in order to unlock the next activity.")
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
			console.error 'rerender activitylistview' #, changedmodel
			curid = @getCurrentId()
			cur = @collection.get(curid)
			next = @collection.get(curid + 1)
			#make it the current one
			cur.notCurrent()
			next.current()
			#render
			@changeScreen()
		jqdisplay: ->
			$('[data-role="button"]').button()
		destroy: ->
			$(window).off("swipeleft")
			$(window).off("swiperight")
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom
			Backbone.View.prototype.remove.call(this)
