
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
	#it "queries object", ->
	#it "removes object", ->
		

describe "box", ->
	
	describe "initializing", ->
		beforeEach ->
			box.initialize()
		it "items are empty array", ->
			(expect box.getitems()).toEqual []
	describe "changing modes", ->
		beforeEach ->
			box.initialize()
			app.initialize()
			
		it "if online, online mode", ->		
			helper.trigger window.document, "online"
			(expect box.mode).toEqual "online"
			
		it "if offline, offline mode", ->		
			helper.trigger window.document, "offline"
			(expect box.mode).toEqual "offline"
	
	describe "custom adding", ->
		beforeEach ->
			el = document.getElementById("stage") #part of spec.html
			el.innerHTML = "<p>embedded text</p>"
		it "adds text found in html element", ->
			text = ($ 'p').html()
			#set mode to offline so it can be in localstorage
			box.mode = "offline"
			box.add text
			(expect window.localStorage['items']).toEqual '["embedded text"]'
			
	describe "uploading to server or localhost", ->
		beforeEach ->
			box.initialize()
			app.initialize()		
			Parse.initialize "pxBn6DIgzMNAtUuG6N08MdPqqGywblo9JPkMwdUe", 
			"CUsQapRcahYD2ztJAAeDMiLhPKxddG0reZFVn6fx"
		describe "offline", ->
			beforeEach ->
				helper.trigger window.document, "offline"
				box.add('hello')
			it "if offline, uses window.localStorage", ->
				items = JSON.parse(window.localStorage['items'])
				(expect items).toEqual ['hello']
		
			it "if offline, items are full", ->
				(expect box.getitems()).toEqual ['hello']
	
		describe "online", ->
			beforeEach ->
				helper.trigger window.document, "online"
				box.add('some info')
			#it "if online, uploads to parse", ->
				# sorry, the test for this is getting too complicated		
			it "if online, items are empty", ->
				(expect box.getitems()).toEqual []


describe "app", ->
	
	describe "initialize: should bind to....", ->
		it "...ondeviceready", ->
			runs ->
				spyOn app, "onDeviceReady"
				app.initialize()
				helper.trigger window.document, "deviceready"
		
			waitsFor (->
				app.onDeviceReady.calls.length > 0
			), "onDeviceReady should be called once", 500
			runs ->
				(expect app.onDeviceReady).toHaveBeenCalled()


		it "...onOnline", ->
			#console.log "APP > ON ONLINE"
			runs ->
				spyOn app, "onOnline"
				app.initialize()
				helper.trigger window.document, "online"

			waitsFor (->
				app.onOnline.calls.length > 0
			), "onOnline should be called once", 500
			
			runs ->
				(expect app.onOnline).toHaveBeenCalled()
				
		it "...onOffline", ->
			#console.log "APP > ON OFFLINE"
			runs ->
				spyOn app, "onOffline"
				app.initialize()
				helper.trigger window.document, "offline"
			
			waitsFor (->
				app.onOffline.calls.length > 0
			), "onOffline should be called once", 500
			
			runs ->
				(expect app.onOffline).toHaveBeenCalled()


	describe "firing", ->
		it "should report that onDeviceReady fired", ->
			spyOn app, "receivedEvent"
			app.onDeviceReady()
			(expect app.receivedEvent).toHaveBeenCalledWith "deviceready"
		it "should report that onOffline fired", ->
			#console.log "FIRING > ON OFFLINE"
			spyOn app, "receivedEvent"
			app.onOffline()
			(expect app.receivedEvent).toHaveBeenCalledWith "offline"
		it "should report that onOnline fired", ->
			#console.log "FIRING > ON ONLINE"
			spyOn app, "receivedEvent"
			app.onOnline()
			(expect app.receivedEvent).toHaveBeenCalledWith "online"

	describe "receivedEvent and set text...", ->
		beforeEach ->
			el = document.getElementById("stage") #part of spec.html
			el.innerHTML = ["<div id='deviceready'>",
							"	<ul class='event'></ul>",
							"</div>"].join('\n')

		it "...saying deviceready", ->
			app.receivedEvent "deviceready"
			text = ($ 'ul.event li:last-child').html()
			(expect text).toEqual "deviceready"

		it "...saying offline", ->
			app.receivedEvent "offline"
			text = ($ 'ul.event li:last-child').html()
			(expect text).toEqual "offline"

		it "...saying online", ->
			app.receivedEvent "online"
			text = ($ 'ul.event li:last-child').html()
			(expect text).toEqual "online"
