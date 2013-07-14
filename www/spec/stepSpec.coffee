define ["../js/models/step"], (Step) ->
	describe "test step", ->
		it "something", ->
			s = new Step
			expect(s.get("title")).toEqual ""


