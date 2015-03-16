/**
 * Created by nico on 16/03/2015.
 */
(function () {
    function Axis(area) {
        this.area = area;
        this.context = area.getContext('2d');
    }

    Axis.prototype.draw = function () {
        this.context.fillRect(this.position.x, this.position.y, 10, 10);
    };

    injector.registerType('axis', ['area', Axis]);
}());
