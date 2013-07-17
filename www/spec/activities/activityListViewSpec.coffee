define ["views/activitylistview", "collections/activitylist"], (ActivityListView, ActivityList) ->
	describe "The Activity List View", ->
		beforeEach ->
			myjson = [
				{id: 3, description: "ho"},
				{id: 1, description: "hey", isCurrent: true, isLocked: false},
				{id: 2, description: "hi"},
			]
			@al = new ActivityList myjson
			@alv = new ActivityListView {collection: @al}
		it "should initialize", ->
			(expect @alv).not.toBeNull()