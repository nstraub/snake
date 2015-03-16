/**
 * Created by nico on 12/03/2015.
 */
(function () {
    function Snake(dispatcher, head, tail, parts_factory, directions, area) {
        this.dispatcher = dispatcher;
        this.head = head;
        this.tail = tail;
        this.parts_factory = parts_factory;
        this.axes = [];
        this.bodies = [];
        this.directions = directions;
        this.area = area;
    }

    Snake.prototype.initialize = function (start_position, length) {
        this.head.position = start_position;
        this.tail.position = {
            x: start_position.x - (length * 10),
            y: start_position.y
        };

        this.tail.follow(this.head);
        this.dispatcher.on('draw', _.bind(this.draw, this));
        this.dispatcher.on('changed:direction', _.bind(this.addAxis, this));

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

    function _move(part) {
        var directions = this.directions;
        switch (part.direction) {
            case directions.up:
                part.position.y -= 10;
                if (part.position.y < 0) {
                    part.position.y = this.area.height -10;
                }
                break;
            case directions.right:
                part.position.x += 10;
                if (part.position.x >= this.area.width) {
                    part.position.x = 0;
                }
                break;
            case directions.down:
                part.position.y += 10;
                if (part.position.y >= this.area.height) {
                    part.position.y = 0;
                }
                break;
            case directions.left:
                part.position.x -= 10;
                if (part.position.x < 0) {
                    part.position.x = this.area.width - 10;
                }
                break;
        }
    }

    Snake.prototype.move = function () {
        _move.call(this, this.head);
        _move.call(this, this.tail);

        if (_.isEqual(this.tail.position, this.tail.following.position)) {
            this.axes.shift();
            _rebuild_body.call(this);
        }

        if (this.head.direction_change_queue.length) {
            this.head.changeDirection(this.head.direction_change_queue.shift());
        } else {
            this.head.changing_direction = false;
        }
    };

    Snake.prototype.grow = function () {
        _move.call(this, this.head);
    };

    function _rebuild_body() {
        this.bodies = [];
        var part_tail_follows = this.axes[0] || this.head;
        this.bodies.push(this.parts_factory.createBody(this.tail, part_tail_follows));

        this.tail.follow(part_tail_follows);

        if (this.axes.length) {
            for (var i = 0; i < this.axes.length - 1; i++) {
                var from_axis = this.axes[i];
                var to_axis = this.axes[i + 1];
                this.bodies.push(this.parts_factory.createBody(from_axis, to_axis));
            }

            this.bodies.push(this.parts_factory.createBody(this.axes[this.axes.length - 1], this.head));
        }
    }

    Snake.prototype.addAxis = function (from, to) {
        this.axes.push(this.parts_factory.createAxis(this.head.position, from, to));

        _rebuild_body.call(this);
    };

    injector.registerType('snake', ['dispatcher', 'head', 'tail', 'partsFactory', 'directions', 'area', Snake]);
} ());
