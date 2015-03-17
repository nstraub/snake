/**
 * Created by nico on 17/03/2015.
 */
'use strict';
(function () {
    function Apple(area, dispatcher) {
        this.canvas = area;
        this.context = area.getContext('2d');
        dispatcher.on('reposition:apple', _.bind(this.reposition, this));
    }

    Apple.prototype.reposition = function () {
        this.tries = 0;
        do {
            this.x = Math.floor(Math.random() * (this.canvas.width - 10) / 10) * 10;
            this.y = Math.floor(Math.random() * (this.canvas.height - 10) / 10) * 10;
        } while (this.isTooCloseToObstacle(Math.floor((30 - this.tries/2)/10) *10) && this.tries++ < 60);
        if (this.tries > 30) {
            throw 'couldn`t position apple after trying 60 times';
        }
    };

    Apple.prototype.isTooCloseToObstacle = function (distance) {
        var perimeter = 10 + distance * 2;
        var imageData = this.context.getImageData(this.x - distance, this.y - distance, perimeter, perimeter).data;
        return !!_.find(imageData, function (point) {
            return point === 255;
        });
    };

    Apple.prototype.draw = function () {
        this.context.fillStyle = 'red';
        this.context.fillRect(this.x +1, this.y +1, 8, 8);
        this.context.fillStyle = 'black';
    };

    injector.registerType('apple', ['area', 'dispatcher', Apple], 'singleton')
}());
