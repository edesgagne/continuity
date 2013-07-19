define ['jquery', 'jquerymobile', 'underscore', 'parse'], 
($, Mobile, _, Parse) ->
	class PopupView extends Parse.View
		tagName: 'div'
		attributes:
			"data-role": "popup"
		initialize: ->
			_.bindAll @, 'render', 'jqdisplay', 'open'
			@render()
			@jqdisplay()
		render: ->
			$(@el).html "<p style='padding: 10px'>" + @options.text + "</p>"
			@ #return itself
		jqdisplay: ->
			$(@el).popup()
		open: ->
			$(@el).popup "open"
			# setTimeout (->
			# 	$(@el).popup "close"
			# ), 2000
		close: ->
			#for all backbone views
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
