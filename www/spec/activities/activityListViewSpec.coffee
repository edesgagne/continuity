define ["views/activitylistview", "collections/activitylist"], (ActivityListView, ActivityList) ->
	describe "The Activity List View", ->
		beforeEach ->
			myjson = [
				{id: 3, description: "ho 3"},
				{id: 1, description: "hey 1", isCurrent: true},
				{id: 2, description: "hi 2"},
			]
			@al = new ActivityList myjson
			@alv = new ActivityListView {collection: @al}
		it "should initialize", ->
			(expect @alv).not.toBeNull()
		it "should re-render when isCurrent changes", ->
			spyOn @alv, 'render' #prevents it from actually executing?
			firstmodel = @al.get(1)
			firstmodel.complete() #triggered by click event
			(expect @alv.render).toHaveBeenCalled()
		
		#NEXT: test for 'prev' functionality
		#if iscurrent, disable "next" button
		#make sure prev goes to prev one
		#then next button is enabled