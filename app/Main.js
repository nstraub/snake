/**
 * Created by nico on 14/03/2015.
 */
'use strict';
(function ($) {
    var frame = 0, speed = 30, animation, action = 'move';
    var directions = _([38, 39, 40, 37]);

    injector.registerMain(function (snake, dispatcher, area) {
        dispatcher.on('stop', function () {
            window.cancelAnimationFrame(animation);
            animation = null;
        });

        dispatcher.on('die', function () {
            dispatcher.trigger('stop');
            dispatcher.off('animate');
        });

        var $speed = $('#speed'),
            $current_score = $('#current-score');

        function changeSpeed() {
            var newSpeed = $speed.val();
            if (isNaN(newSpeed)) {
                $speed.val(31 - speed);
            } else if (newSpeed > 30) {
                $speed.val(30);
                speed = 1;
            } else {
                speed = 31 - newSpeed;
            }
        }

        $speed.blur(changeSpeed);
        $speed.keydown(function (e) {
            if (e.which === 13) {
                changeSpeed();
            }
        });

        var scotland_yard = false;

        var $scotland_yard = $('#scotland-yard');
        $scotland_yard.change(function () {
            scotland_yard = $scotland_yard.prop('checked')
        });

        dispatcher.on('grow', function () {
            speed = accelerate(speed);
            action = 'grow';
            $current_score.text(+$current_score.text() +10);
            $speed.val(Math.round((31 - speed) * 10) / 10);
        });

        function accelerate(speed) {
            if (speed > 1) {
                if (speed > 10) {
                    speed--;
                } else if (speed > 5) {
                    speed -= .5;
                } else if (speed > 3) {
                    speed -= .2;
                } else {
                    speed -= .1;
                }
            }
            return speed;
        }

        function init() {
            dispatcher.trigger('die');

            dispatcher.on('animate', function () {
                animation = window.requestAnimationFrame(animate);
            });

            snake.initialize({x: 60, y: 20}, 10);

            dispatcher.trigger('reposition:apple');

            dispatcher.trigger('animate');
            $speed.val()
        }

        var scotland_yard_frame = 0;

        dispatcher.on('draw-all', function () {
            if (scotland_yard) {
                dispatcher.trigger('clear');
                if (scotland_yard_frame++ === 4) {
                    dispatcher.trigger('draw');
                    scotland_yard_frame = 0;
                }
            } else {
                dispatcher.trigger('draw');
            }
        });


        function animate() {
            if (frame++ % Math.ceil(speed) === 0) {
                var this_action = action;
                snake[action]();
                if (this_action === 'grow'){
                    action = 'move';
                }

                dispatcher.trigger('draw-all');
            }
            dispatcher.trigger('animate')
        }

        init();

        $('#game').click(init);

        $(document).keydown(function (e) {
            if (e.which === 32) {
                if (animation) {
                    dispatcher.trigger('stop')
                } else {
                    dispatcher.trigger('animate')
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
        
        $('#size--small').click(function () {
            area.width = 250;
            area.height = 250;
            init();
        });
        $('#size--medium').click(function () {
            area.width = 350;
            area.height = 350;
            init();
        });

        $('#size--large').click(function () {
            area.width = 500;
            area.height = 500;
            init();
        });
    });

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
