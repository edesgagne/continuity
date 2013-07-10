define ['jquery', 'jquerymobile', 'underscore', 'parse', 'models/step'], ($, Mobile, _, Parse, Step) ->
	class window.StepList extends Parse.Collection
		model: Step
		comparator: (object) ->
			return object.get('step_num')