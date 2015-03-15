/**
 * Created by nico on 12/03/2015.
 */
(function () {
    function Snake(dispatcher, head, tail, parts_factory) {
        this.dispatcher = dispatcher;
        this.head = head;
        this.tail = tail;
        this.parts_factory = parts_factory;
        this.axes = [];
        this.bodies = [];
    }

    Snake.prototype.initialize = function (start_position, length) {
        this.head.position = start_position;
        this.tail.position = {
            x: start_position.x - (length * 10),
            y: start_position.y
        };

        this.tail.follow(this.head);
        this.dispatcher.on('draw', this.draw);

        this.bodies.push(this.parts_factory.createBody(this.tail, this.head));
    };

    Snake.prototype.draw = function () {
        this.dispatcher.trigger('clear');
        this.head.draw();
        for (var i = 0; i < this.bodies.length; i++) {
            this.bodies[i].draw();
        }
        this.tail.draw();
    };

    Snake.prototype.move = function () {
        throw 'not implemented';
    };

    Snake.prototype.grow = function () {
        throw 'not implemented';
    };

    injector.registerType('snake', ['dispatcher', 'head', 'tail', 'partsFactory', Snake]);
} ());
