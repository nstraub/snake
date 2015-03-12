/**
 * Created by nico on 11/03/2015.
 */
(function () {
    function Body(dispatcher, canvas, directions) {
        this.dispatcher = dispatcher;
        this.canvas = canvas;
        this.context = canvas.getContext('2d');
        this.directions = directions;
    }

    Body.prototype.draw = function () {
        var from_position = this.from.position,
            to_position = this.to.position,
            direction = this.from.direction || this.from.to_direction;

        if (direction === this.directions.left || direction === this.directions.right) {
            this.context.fillRect(from_position.x, from_position.y, to_position.x - from_position.x, 10);
        } else {
            this.context.fillRect(from_position.x, from_position.y, 10, to_position.y - from_position.y);
        }
    };

    Body.prototype.locatedAt = function (position) {
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

        return position[precise_checker] === high_point[precise_checker]
            && position[range_checker] < high_point[range_checker]
            && position[range_checker] > low_point[range_checker];
    };

    injector.registerType('body', ['dispatcher', 'canvas', 'directions', Body], 'transient')
}());
