/**
 * Created by nico on 14/03/2015.
 */
(function ($) {
    var frame = 0, maze, speed = 20, animation;
    var directions = _([38, 39, 40, 37]);
    function Main (snake, dispatcher, area) {
        snake.initialize({x: 60, y: 20}, 10);
        var context = area.getContext('2d');

        dispatcher.on('clear', function () {
            context.clearRect(0, 0, area.width, area.height);
            if (maze) {
                maze.draw();
            }
        });

        dispatcher.trigger('draw');

        function animate() {
            if (frame++ % Math.ceil(speed) === 0) {
                snake.move();
                dispatcher.trigger('draw');
                /*            if (snakeHelper.eatApple(snake, apple)) {
                 $currentScore.text(+$currentScore.text() +10);
                 speed = snakeHelper.accelerate(speed);
                 $speed.val(Math.round((31 - speed) * 10) / 10);
                 }
                 if (!apple.x) {
                 apple.reposition();
                 }
                 apple.draw();*/
            }
            if (snake.isDead) {
                window.cancelAnimationFrame(animation);
            } else {
                animation = window.requestAnimationFrame(animate);
            }
        }

        animate();

        $(document).keydown(function (e) {
            if (e.which === 32) {
                if (animation) {
                    window.cancelAnimationFrame(animation);
                    animation = null;
                } else {
                    draw();
                }
            } else {
                var index = directions.findIndex(function (item) {
                    return item == e.which;
                });

                if (index > -1) {
                    dispatcher.trigger('change:direction', index);
                }
            }
        });

    }

    injector.registerMain(['snake', 'dispatcher', 'area', Main]);

    $(function () {
        var dispatcher = _.clone(Backbone.Events); //TODO replace with a non backbone dispatcher... or write one

        injector.registerProvider('dispatcher', function () {
            return dispatcher;
        });

        injector.registerProvider('area', function () {
            return document.getElementById('game');
        });

        injector.registerType('directions', function () {
            this.up = 0;
            this.right = 1;
            this.down = 2;
            this.left = 3;
        }, 'singleton');

        injector.run();

    });
}(jQuery));
