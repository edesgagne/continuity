define(["../js/models/step"], function (Step) {
    describe("test step", function () {

        it("something", function() {
			s = new Step
            expect(s.get("title")).toEqual("")
        });

    });
});