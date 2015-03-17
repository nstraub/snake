/**
 * Created by nico on 16/03/2015.
 */
'use strict';
(function () {
    function Map (area, dispatcher, apple) {
        this.area = area;
        this.context = area.getContext('2d');
        this.dispatcher = dispatcher;
        this.apple = apple;
        dispatcher.on('clear', _.bind(this.clear, this));
    }

    Map.prototype.clear = function () {
        this.context.clearRect(0, 0, this.area.width, this.area.height);
        if (!this.apple.x) {
            this.apple.reposition();
        }
        this.apple.draw();
    };

    Map.prototype.getItemAt = function (x, y) {
        if (this.apple.x === x && this.apple.y === y) {
            return this.apple;
        }
        return null;
    };

    injector.registerType('map', ['area', 'dispatcher', 'apple', Map], 'singleton');
}());
