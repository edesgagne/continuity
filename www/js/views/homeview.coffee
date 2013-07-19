define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/hometemplate.html'], 
($, Mobile, _, Parse, hometemplate) ->
	class HomeView extends Parse.View
		tagName: "div"
		template: _.template hometemplate
		initialize: ->
			_.bindAll @, 'render', 'close'
		render: ->
			$(@el).html @template {user: window.localStorage["user"]}
		close: ->
			$(@el).empty()
			#for all backbone views
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
			
			delete this
