define ["../js/models/step"], (Step) ->
	describe "test step", ->
		it "something", ->
			s = new Step
			expect(s.get("title")).toEqual ""
	describe "jasmine-jquery", ->
		it "gets lib", ->
			expect($('<input type="checkbox" checked="checked"/>')).toBeChecked()


