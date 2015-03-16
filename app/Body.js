/**
 * Created by nico on 11/03/2015.
 */
'use strict';
(function () {
    function Body(dispatcher, area, directions) {
        this.dispatcher = dispatcher;
        this.area = area;
        this.context = area.getContext('2d');
        this.directions = directions;
    }

    Body.prototype.draw = function () {
        var from_position = this.from.position,
            to_position = this.to.position,
            direction = this.from.direction;

        if (direction === undefined) {
            direction = this.from.to_direction;
        }

        switch (direction) {
            case this.directions.up:
                if (from_position.y < to_position.y) {
                    this.context.fillRect(from_position.x, from_position.y, 10, to_position.y - from_position.y);
                } else {
                    this.context.fillRect(from_position.x, from_position.y, 10, this.area.height - from_position.y);
                    this.context.fillRect(from_position.x, 0, 10, to_position.y);
                }
                break;
            case this.directions.down:
                if (from_position.y > to_position.y) {
                    this.context.fillRect(from_position.x, from_position.y, 10, to_position.y - from_position.y);
                } else {
                    this.context.fillRect(from_position.x, to_position.y, 10, this.area.height - to_position.y);
                    this.context.fillRect(from_position.x, 0, 10, from_position.y);
                }
                break;
            case this.directions.right:
                if (from_position.x < to_position.x) {
                    this.context.fillRect(from_position.x, from_position.y, to_position.x - from_position.x, 10);
                } else {
                    this.context.fillRect(from_position.x, from_position.y, this.area.width - from_position.x, 10);
                    this.context.fillRect(0, from_position.y, to_position.x, 10);
                }
                break;
            case this.directions.left:
                if (from_position.x > to_position.x) {
                    this.context.fillRect(from_position.x, from_position.y, to_position.x - from_position.x, 10);
                } else {
                    this.context.fillRect(to_position.x, from_position.y, this.area.width - to_position.x, 10);
                    this.context.fillRect(0, from_position.y, from_position.x, 10);
                }
                break;
            default:
                this.context.fillRect(from_position.x, from_position.y, to_position.x - from_position.x, 10);

        }
    };

    Body.prototype.isLocatedAt = function (position) {
        var high_point, low_point, precise_checker, range_checker;

        if (this.from.direction === this.directions.right || this.from.direction === this.directions.left) {
            precise_checker ='x';
            range_checker = 'y';
        } else {
            precise_checker ='y';
            range_checker = 'x';
        }

        if (this.from.position[range_checker] > this.to.position[range_checker]) {
            high_point = this.from.position;
            low_point = this.to.position;
        } else {
            low_point = this.from.position;
            high_point = this.to.position;
        }

        return (position[precise_checker] - high_point[precise_checker] >= 0 || position[precise_checker] - high_point[precise_checker] <= 10 )
            && position[range_checker] <= high_point[range_checker]
            && position[range_checker] >= low_point[range_checker];
    };

    injector.registerType('body', ['dispatcher', 'area', 'directions', Body], 'transient')
}());
