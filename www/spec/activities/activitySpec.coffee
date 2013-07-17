define ["../../js/models/activity"], (Activity) ->
	describe "The Activity Class", ->
		it "should initialize", ->
			a = new Activity
			(expect a).not.toBeNull()