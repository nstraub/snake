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

    describe 'direction: up', () ->
        describe 'within bounds', prepare_draw_block {x: 20, y: 50}, {x: 20, y: 20}, directions.up, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 10, 30

        describe 'out of bounds', prepare_draw_block {x: 20, y: 10}, {x: 20, y: 180}, directions.up, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20

    describe 'direction: right', () ->
        describe 'within bounds', prepare_draw_block {x: 20, y: 20}, {x: 50, y: 20}, directions.right, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 40, 10
        describe 'out of bounds', prepare_draw_block {x: 190, y: 20}, {x: 20, y: 20}, directions.right, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 190, 20, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 30, 10

    describe 'direction: down', () ->
        describe 'within bounds', prepare_draw_block {x: 20, y: 20}, {x: 20, y: 50}, directions.down, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 10, 40
        describe 'out of bounds', prepare_draw_block {x: 20, y: 180}, {x: 20, y: 20}, directions.down, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 30
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20

    describe 'direction: left', () ->
        describe 'within bounds', prepare_draw_block {x: 50, y: 20}, {x: 20, y: 20}, directions.left, () ->
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 20, 30, 10
        describe 'out of bounds', prepare_draw_block {x: 20, y: 20}, {x: 190, y: 20}, directions.left, () ->
            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 190, 20, 10, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10

    ###it 'draws a horizontal line between tail and head', injector.inject ['tail', 'head', (tail, head) ->
        head.position = x: 50, y: 20
        head.direction = directions.right;

        tail.position = x: 10, y: 20
        tail.direction = directions.right;

        body.from = tail;
        body.to = head;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
    ]

    it 'draws a vertical line between tail and head', injector.inject ['tail', 'head', (tail, head) ->
        head.position = x: 20, y: 10
        head.direction = directions.up;

        tail.position = x: 20, y: 50
        tail.direction = directions.up;

        body.from = tail;
        body.to = head;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
    ]

    it 'draws a horizontal line between axis and head', injector.inject ['axis', 'head', (axis, head) ->
        head.position = x: 50, y: 20
        head.direction = directions.right;

        axis.position = x: 10, y: 20
        axis.to_direction = directions.right;

        body.from = axis;
        body.to = head;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
    ]

    it 'draws a vertical line between axis and head', injector.inject ['axis', 'head', (axis, head) ->
        head.position = x: 20, y: 10
        head.direction = directions.up;

        axis.position = x: 20, y: 50
        axis.to_direction = directions.up;

        body.from = axis;
        body.to = head;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
    ]


    it 'draws a horizontal line between tail and axis', injector.inject ['tail', 'axis', (tail, axis) ->
        axis.position = x: 50, y: 20
        axis.from_direction = directions.right;

        tail.position = x: 10, y: 20
        tail.direction = directions.right;

        body.from = tail;
        body.to = axis;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
    ]

    it 'draws a vertical line between tail and axis', injector.inject ['tail', 'axis', (tail, axis) ->
        axis.position = x: 20, y: 50
        axis.from_direction = directions.up;

        tail.position = x: 20, y: 10
        tail.direction = directions.up;

        body.from = tail;
        body.to = axis;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
    ]

    it 'draws a horizontal line between axis and axis', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
        axis_to.position = x: 50, y: 20
        axis_to.from_direction = directions.right;

        axis_from.position = x: 10, y: 20
        axis_from.to_direction = directions.right;

        body.from = axis_from;
        body.to = axis_to;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
    ]

    it 'draws a vertical line between axis and axis', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
        axis_to.position = x: 20, y: 50
        axis_to.from_direction = directions.up;

        axis_from.position = x: 20, y: 10
        axis_from.to_direction = directions.up;

        body.from = axis_from;
        body.to = axis_to;

        body.draw()

        expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
    ]

    it 'draws an upward vertical line that overlaps the area', injector.inject ['axis', 'axis',
        (axis_from, axis_to) ->
            axis_to.position = x: 20, y: 180
            axis_to.from_direction = directions.up;

            axis_from.position = x: 20, y: 20
            axis_from.to_direction = directions.up;

            body.from = axis_from;
            body.to = axis_to;

            body.draw()

            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 20

    ]

    it 'draws a downward vertical line that overlaps the area', injector.inject ['axis', 'axis',
        (axis_from, axis_to) ->
            axis_to.position = x: 20, y: 20
            axis_to.from_direction = directions.down;

            axis_from.position = x: 20, y: 180
            axis_from.to_direction = directions.down;

            body.from = axis_from;
            body.to = axis_to;

            body.draw()

            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20
            expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 20

    ]

    it 'draws a horizontal line to the right that overlaps the area', injector.inject ['axis', 'axis',
        (axis_from, axis_to) ->
            axis_to.position = x: 20, y: 20
            axis_to.from_direction = directions.right;

            axis_from.position = x: 180, y: 20
            axis_from.to_direction = directions.right;

            body.from = axis_from;
            body.to = axis_to;

            body.draw()

            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 180, 20, 20, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10
    ]


    it 'draws a horizontal line to the left that overlaps the area', injector.inject ['axis', 'axis',
        (axis_from, axis_to) ->
            axis_to.position = x: 180, y: 20
            axis_to.from_direction = directions.left;

            axis_from.position = x: 20, y: 20
            axis_from.to_direction = directions.left;

            body.from = axis_from;
            body.to = axis_to;

            body.draw()

            expect(body.context.fillRect).toHaveBeenCalledTwice()
            expect(body.context.fillRect).toHaveBeenCalledWith 180, 20, 20, 10
            expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10
    ]###
]
