describe "step", ->
	it "creates step", ->
		s = new Step
		(expect s.get('strategies')).toEqual('[]')

describe "parse", ->
	beforeEach ->
		Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", 
		"CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"
		
	it "creates object", ->
		waitsFor (->
			TestObject = Parse.Object.extend "TestObject"
			testObject = new TestObject()
			@itworked = testObject.save foo: "bar", cake: "car"
		), "wait for it to upload to server", 500
		
		runs ->
			(expect @itworked).toBeTruthy()