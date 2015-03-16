/**
 * Created by nico on 14/03/2015.
 */
(function ($) {
    var frame = 0, maze, speed = 5, animation;
    function Main (snake, dispatcher, area) {
        snake.initialize({x: 60, y: 20}, 4);
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
