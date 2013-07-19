define ['jquery', 'jquerymobile', 'underscore', 'parse', 'text!templates/helptemplate.html'], 
($, Mobile, _, Parse, helptemplate) ->
	class HelpView extends Parse.View
		#el: '[data-role="content"]'
		tagName: "div"
		template: _.template helptemplate
		initialize: ->
			_.bindAll @, 'render', 'jqdisplay'
		render: ->
			$(@el).html @template
		jqdisplay: ->
			$('[data-role="button"]').button();
		close: ->
			console.log 'inside close method of help view'
			$(@el).empty()
			@undelegateEvents()
			$(@el).removeData().unbind()
			@remove() #removes view from dom, should also undelegateEvents
			@unbind() #unbinds anytime we called this.trigger()
			Parse.View.prototype.remove.call(this)
			
			delete this