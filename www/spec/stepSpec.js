// Generated by CoffeeScript 1.6.3
(function() {
  define(["../js/models/step"], function(Step) {
    describe("test step", function() {
      return it("something", function() {
        var s;
        s = new Step;
        return expect(s.get("title")).toEqual("");
      });
    });
    return describe("jasmine-jquery", function() {
      return it("gets lib", function() {
        return expect($('<input type="checkbox" checked="checked"/>')).toBeChecked();
      });
    });
  });

}).call(this);
