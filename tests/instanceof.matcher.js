var add_instanceof_matcher = function () {
    jasmine.addMatchers({
        toBeInstanceOf: function () {
            return {
                compare: function (actual, expected) {
                    var result;
                    result = {
                        pass: actual instanceof expected
                    };
                    if (result.pass) {
                        result.message = 'Expected ' + actual + ' not to be an instance of ' + expected;
                    } else {
                        result.message = 'Expected ' + actual + ' to be an instance of ' + expected;
                    }
                    return result;
                }
            };
        }
    });
};
