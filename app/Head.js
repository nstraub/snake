/**
 * Created by nico on 11/03/2015.
 */
'use strict';
(function () {
    function Head (dispatcher, area, directions) {
        this.dispatcher = dispatcher;
        this.area = area;
        this.context = area.getContext('2d');
        this.directions = directions;
        this.direction = directions.right;
        this.dispatcher.on('change:direction', _.bind(this.enqueueDirectionChange, this))
        this.direction_change_queue = [];
    }

    Head.prototype.eat = function (block) {
        if (!block) {
            return;
        }
        if (block instanceof injector.getType('body')) {
            this.dispatcher.trigger('die');
        } else if (block instanceof injector.getType('apple')) {
            this.dispatcher.trigger('grow');
        }
    };

    Head.prototype.draw = function () {
        this.context.fillRect(this.position.x, this.position.y, 10, 10)
    };

    Head.prototype.changeDirection = function (direction) {
        var current_direction = this.direction;

        if (current_direction !== direction && (current_direction + direction) % 2 !== 0) {
            this.changing_direction = true;
            this.direction = direction;
            this.dispatcher.trigger('changed:direction', current_direction, direction)
        }
    };

    Head.prototype.enqueueDirectionChange = function (direction) {
        if (this.changing_direction) {
            this.direction_change_queue.push(direction)
        } else {
            this.changeDirection(direction);
        }
    };


    injector.registerType('head', ['dispatcher', 'area', 'directions', Head], 'singleton');
}());
