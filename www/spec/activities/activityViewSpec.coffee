define ["views/activityview", "models/activity"], (ActivityView, Activity) ->
	describe "The Activity View", ->
		beforeEach ->
			@a = new Activity({id: 1, description: "activity desc"})
			@v = new ActivityView {model: @a}
			$("[data-role='content']").html @v.el
		it "should initialize", ->
			(expect @v).not.toBeNull()
		it "should make activity completed when checked", ->
			$("#unchecked").trigger "click"
			(expect @a.get "isCompleted").toEqual true
