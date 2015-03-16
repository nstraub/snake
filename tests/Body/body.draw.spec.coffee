body_draw_spec = injector.inject ['body', 'directions', (body, directions) ->
    beforeEach injector.inject ['area', (area) ->
        body.area = area
        body.context = area.getContext('2d')
    ]

    prepare_end = (part, position, direction) ->
        part.position = position
        part.direction = direction
        return part

    prepare_axis = (axis, position, direction) ->
        axis.position = position
        axis.from_direction = axis.to_direction = direction
        return axis

    prepare_draw_block = (from_bound, to_bound, direction, run_assertions) ->
        return () ->
            it 'draws a line between head and tail', injector.inject ['head', 'tail', (head, tail) ->
                body.from = prepare_end tail, from_bound, direction
                body.to = prepare_end head, to_bound, direction
            ]
            it 'draws a line between head and axis', injector.inject ['head', 'axis', (head, axis) ->
                body.from = prepare_axis axis, from_bound, direction
                body.to = prepare_end head, to_bound, direction
            ]
            it 'draws a line between axis and axis', injector.inject ['axis', 'axis', (axis1, axis2) ->
                body.from = prepare_axis axis1, from_bound, direction
                body.to = prepare_axis axis2, to_bound, direction
            ]
            it 'draws a line between axis and tail', injector.inject ['axis', 'tail', (axis, tail) ->
                body.from = prepare_end tail, from_bound, direction
                body.to = prepare_axis axis, to_bound, direction
            ]

            afterEach () ->
                body.draw()
                run_assertions()

    assert_square = (direction, run_assertion) ->
        return injector.inject ['axis', 'head', (axis, head) ->
            body.from = prepare_axis axis, {x: 10, y: 10}, direction
            body.to = prepare_end head, {x: 10, y: 10}, direction

            body.draw()

            run_assertion()
        ]
    describe 'direction: up', () ->
        it 'draws a square when start and end are the same', assert_square directions.up, () -> expect(body.context.fillRect).toHaveBeenCalledWith 10, 10, 10, 0

        describe 'within bounds', prepare_draw_block {x: 20, y: 50}, {x: 20, y: 20}, directions.up, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 10, 30

        describe 'out of bounds', prepare_draw_block {x: 20, y: 10}, {x: 20, y: 180}, directions.up, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20

    describe 'direction: right', () ->
        it 'draws a square when start and end are the same', assert_square directions.right, () -> expect(body.context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10
        describe 'within bounds', prepare_draw_block {x: 20, y: 20}, {x: 50, y: 20}, directions.right, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 40, 10
        describe 'out of bounds', prepare_draw_block {x: 190, y: 20}, {x: 20, y: 20}, directions.right, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 190, 20, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 30, 10

    describe 'direction: down', () ->
        it 'draws a square when start and end are the same', assert_square directions.down, () -> expect(body.context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10
        describe 'within bounds', prepare_draw_block {x: 20, y: 20}, {x: 20, y: 50}, directions.down, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 10, 40
        describe 'out of bounds', prepare_draw_block {x: 20, y: 180}, {x: 20, y: 20}, directions.down, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 30
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20

    describe 'direction: left', () ->
        it 'draws a square when start and end are the same', assert_square directions.left, () -> expect(body.context.fillRect).toHaveBeenCalledWith 10, 10, 0, 10
        describe 'within bounds', prepare_draw_block {x: 50, y: 20}, {x: 20, y: 20}, directions.left, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 30, 10
        describe 'out of bounds', prepare_draw_block {x: 20, y: 20}, {x: 190, y: 20}, directions.left, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 190, 20, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10

]
