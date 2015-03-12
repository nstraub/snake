/**
 * Created by nico on 11/03/2015.
 */
(function () {
    function Tail (dispatcher) {
        this.dispatcher = dispatcher;
    }

    Tail.prototype.draw = function (position) {
        this.context.fillRect(position.x, position.y, 10, 10)
    };

    Tail.prototype.follow = function (part) {
        if (part instanceof injector.getType('head')) {
            this.direction = part.direction;
        } else {
            this.direction = part.from_direction;
        }

        this.following = part;
    };

    injector.registerType('tail', ['dispatcher', Tail], 'singleton');
}());
