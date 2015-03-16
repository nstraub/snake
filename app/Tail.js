/**
 * Created by nico on 11/03/2015.
 */
'use strict';
(function () {
    function Tail (dispatcher, area) {
        this.dispatcher = dispatcher;
        this.area = area;
        this.context = area.getContext('2d');
    }

    Tail.prototype.draw = function () {
        this.context.fillRect(this.position.x, this.position.y, 10, 10)
    };

    Tail.prototype.follow = function (part) {
        if (part instanceof injector.getType('head')) {
            this.direction = part.direction;
        } else {
            this.direction = part.from_direction;
        }

        this.following = part;
    };

    injector.registerType('tail', ['dispatcher', 'area', Tail], 'singleton');
}());
