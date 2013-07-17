define ["../../js/models/activity"], (Activity) ->
	describe "Activity", ->
		it "initializes", ->
			a = new Activity
			(expect a).not.toBeNull()