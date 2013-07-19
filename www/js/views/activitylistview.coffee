define ['jquery', 'jquerymobile', 'underscore', 'parse', 'collections/activitylist', 'views/activityview', 'text!templates/activitylisttemplate.html'], 
($, Mobile, _, Parse, ActivityList, ActivityView, activitylisttemplate) ->
	class ActivityListView extends Parse.View
		tagName: 'div'
		template: _.template activitylisttemplate
		events:
			'click #prev': 'prev'
			'click #next': 'next'
			#'swiperight window': 'prev'
			#'swipeleft window': 'next'
		initialize: ->
			myjson = window.queries.getMyJSON("js/json/activities.json")
			console.log myjson
			@al = new ActivityList myjson
			@collection = @al
			
			_.bindAll @, 'render', 'rerender', 'getCurrentId', 'getCurrent', 'prev', 'next', 'changeScreen', 'jqdisplay', 'close'
			@collection.on 'change:isCompleted', @rerender, @
			$(window).bind "swiperight", _.bind(@prev, @)
			$(window).bind "swipeleft", _.bind(@next, @)
			@subview = null
			
			@firstcall = true
		getCurrentId: ->
			arr = @collection.pluck("isCurrent")
			curid = arr.indexOf(true) + 1 #because arrays are 0 based
			return curid
		getCurrent: ->
			curid = @getCurrentId()
			cur = @collection.get(curid)
			return cur
		render: ->
			if @firstcall
				#initialize viewpointer
				@viewpointer = @getCurrentId()
				@firstcall = false
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
			console.log 'changescreen'
			if @subview #already a subview
				console.log 'closing a subview', @subview
				@subview.close()
			#changes screen to where the viewpointer is
			newscreen = @collection.get(@viewpointer)
			av = new ActivityView {model: newscreen}
			@subview = av
			console.log av.render().el
			#append to actual view and add buttons
			$(@el).html @template()
			$(@el).append av.el
						
			@jqdisplay()
			

				
			
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
			console.log 'jq display of activitylistview'
			$('[data-role="button"]').button()
			
			console.log 'about to disable'
			console.log @viewpointer, @getCurrentId()
			#disables/enables buttons accordingly
			if @viewpointer == 1
				console.log 'disabling prev'
				$('#prev').button("disable")
			if @viewpointer == @getCurrentId()
				#whatever is next is locked
				console.log 'disabling next'
				$('#next').button("disable")
		close: ->
			
			if @subview
				console.log 'closing subview final'
				@subview.close()
				
			@collection.off 'change:isCompleted', @rerender, @
			$(window).off("swipeleft")
			$(window).off("swiperight")
			
			#for all backbone views
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
