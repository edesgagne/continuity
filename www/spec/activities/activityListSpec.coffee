define ["../../js/collections/steplist"], (StepList) ->
	describe "The Activity List", ->
		beforeEach ->
			@al = new StepList
		it "should initialize", ->
			(expect @al).not.toBeNull()
