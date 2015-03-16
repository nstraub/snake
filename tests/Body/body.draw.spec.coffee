body_draw_spec = injector.inject ['body', 'directions', (body, directions) ->
    beforeEach injector.inject ['area', (area) ->
        body.area = area
        body.context = area.getContext('2d')
    ]

    it 'draws a horizontal line between tail and head', injector.inject ['tail', 'head', (tail, head) ->
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
        head.position = x: 20, y: 50
        head.direction = directions.up;

        tail.position = x: 20, y: 10
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
        head.position = x: 20, y: 50
        head.direction = directions.up;

        axis.position = x: 20, y: 10
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
            axis_to.position = x: 20, y: 20
            axis_to.from_direction = directions.up;

            axis_from.position = x: 20, y: 180
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
            axis_to.position = x: 20, y: 180
            axis_to.from_direction = directions.down;

            axis_from.position = x: 20, y: 20
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
    ]
]
