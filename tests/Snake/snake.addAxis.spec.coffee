snake_add_axis_spec = injector.harness ['snake', 'directions', (snake, directions) ->
    axis = null
    body1 = null
    body2 = null
    beforeEach injector.inject ['partsFactory', 'directions', (parts_factory, directions) ->
        axis = injector.instantiate('axis');
        axis.position = x: 20, y: 20
        axis.from_direction = directions.right
        axis.to_direction = directions.up

        snake.axes = []
        snake.parts_factory = parts_factory
        parts_factory.createAxis.withArgs({x: 20, y: 20}, directions.right, directions.up).returns axis

        body1 = injector.instantiate('body')
        body2 = injector.instantiate('body')

        body1.from = snake.tail
        body1.to = axis

        body2.from = axis
        body2.to = snake.head

        parts_factory.createBody.withArgs(snake.tail, axis).returns body1
        parts_factory.createBody.withArgs(axis, snake.head).returns body2

        snake.head.direction = directions.up;
        snake.head.position =
            y: 20
            x: 20

        snake.addAxis(directions.right, directions.up)

    ]
    it 'adds a new axis with given directions', () ->
        expect(snake.axes.length).toBe 1
        expect(snake.axes[0]).toBe axis


    it 'rebuilds body', () ->
        expect(snake.bodies[0]).toBe body1
        expect(snake.bodies[1]).toBe body2

]
