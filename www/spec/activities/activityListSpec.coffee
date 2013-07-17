define ["collections/activitylist"], (ActivityList) ->
	describe "The Activity List", ->
		beforeEach ->
			myjson = [
				{id: 3, description: "ho"},
				{id: 1, description: "hey", isCurrent: true},
				{id: 2, description: "hi"},
			]
			@al = new ActivityList myjson
			@firstmodel = @al.get(1)
			@secondmodel = @al.get(2)
		it "should initialize", ->
			(expect @al).not.toBeNull()
		it "should create models from json", ->
			(expect @al.models.length).toEqual 3
		it "should sort itself", ->
			#@al.sort()
			arr = []
			lastid = 0
			for model in @al.models
				(expect model.id).toEqual lastid + 1
				lastid++
		it "should mark the first one as current", ->
			(expect @firstmodel.get("isCurrent")).toEqual true
		# it "upon complete, should move isCurrent to next model", ->
		# 	@firstmodel.complete()
		# 	(expect @secondmodel.get("isCurrent")).toEqual true
		# it "should properly handle finishing the last model", ->
		# 	spyOn @al, "finishedList"
		# 	
		# 	@firstmodel.complete()
		# 	@secondmodel.complete()
		# 	@al.get(3).complete()
		# 	
		# 	(expect @al.finishedList).toHaveBeenCalled()