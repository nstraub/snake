/**
 * Created by nico on 12/03/2015.
 */
(function () {
    function PartsFactory() {}

    PartsFactory.prototype.createBody = function (from, to) {
        var body = injector.instantiate('body');
        body.from = from;
        body.to = to;
        return body;
    };

    injector.registerType('partsFactory', PartsFactory, 'singleton');
}());
