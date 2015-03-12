/**
 * Created by nico on 11/03/2015.
 */
'use strict';
(function () {
    function Head (dispatcher, canvas, directions) {
        this.dispatcher = dispatcher;
        this.canvas = canvas;
        this.context = canvas.getContext('2d');
        this.directions = directions;
        this.direction = directions.right;
    }

    Head.prototype.eat = function (block) {
        if (!block) {
            return;
        }
        if (block instanceof injector.getType('wall') || block instanceof injector.getType('body')) {
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

        this.direction = direction;

        this.dispatcher.trigger('change:direction', current_direction, direction)
    };


    injector.registerType('head', ['dispatcher', 'canvas', 'directions', Head], 'transient');
}());
