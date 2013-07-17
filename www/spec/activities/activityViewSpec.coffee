define ["../../js/views/activityview"], (ActivityView) ->
	describe "The Activity View", ->
		beforeEach ->
			@a = new Activity({id: 1, description: "activity desc"})
			@v = new ActivityView {model: @a}
			$("#activitystage").html @v.el
		it "should initialize", ->
			(expect @v).not.toBeNull()
		it "should make activity completed when checked", ->
			$("#check").trigger "click"
			(expect @a.get "isCompleted").toEqual true
