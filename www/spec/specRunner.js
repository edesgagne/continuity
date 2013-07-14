require.config({
	//base url not working
	//baseURL: '../js/',
	//urlArgs: 'cb=' + Math.random(),
	paths: {
		'jquery': '../js/lib/jquery-1.8.3',
		'jquerymobile': '../js/lib/jquery-mobile/jquery.mobile-1.3.1',
		'underscore': '../js/lib/underscore',
		'parse': '../js/lib/parse-1.2.8',
		'jasmine': 'lib/jasmine-1.2.0/jasmine',
		'jasmine-html': 'lib/jasmine-1.2.0/jasmine-html',
		//'spec': 'spec'
	},
	shim: {
		"underscore": {
			exports: "_"
		},
		"parse": {
			deps: ['underscore', 'jquery'],
			exports: "Parse"
		},
		"jasmine": {
			exports: 'jasmine'
		},
		"jasmine-html": {
			deps: ['jasmine'],
			exports: 'jasmine'
		}
	}
});

require(['jquery', 'jasmine-html'], function ($, jasmine) {

    var jasmineEnv = jasmine.getEnv();
    jasmineEnv.updateInterval = 1000;

    var htmlReporter = new jasmine.HtmlReporter();

    jasmineEnv.addReporter(htmlReporter);

    jasmineEnv.specFilter = function (spec) {
        return htmlReporter.specFilter(spec);
    };

    var specs = [];

	specs.push('parseSpec');
	specs.push('stepSpec');



    $(function () {
        require(specs, function (spec) {
            jasmineEnv.execute();
        });
    });

});