/**
 * Created by nico on 12/03/2015.
 */
'use strict';
(function () {
    function PartsFactory() {}

    PartsFactory.prototype.createBody = function (from, to) {
        var body = injector.instantiate('body');
        body.from = from;
        body.to = to;
        return body;
    };

    PartsFactory.prototype.createAxis = function (position, from_direction, to_direction) {
        var axis = injector.instantiate('axis');
        axis.position = _.clone(position);
        axis.from_direction = from_direction;
        axis.to_direction = to_direction;
        return axis;
    };

    injector.registerType('partsFactory', PartsFactory, 'singleton');
}());
