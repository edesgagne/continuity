define ["../../js/models/activity"], (Activity) ->
	describe "The Activity Class", ->
		beforeEach ->
			@a = new Activity
		it "should initialize", ->
			(expect @a).not.toBeNull()
		it "should have proper defaults", ->
			(expect @a.get("id")).toEqual 0
			(expect @a.get("description")).toEqual ""
			(expect @a.get("isCompleted")).toEqual false
			(expect @a.get("isCurrent")).toEqual false
			(expect @a.get("isLocked")).toEqual true
		it "should properly go to the next activity", ->
			@a.complete()
			(expect @a.get("isCompleted")).toEqual true
			(expect @a.get("isCurrent")).toEqual false