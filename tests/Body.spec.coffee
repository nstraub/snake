describe 'Body', injector.inject ['body', 'directions', (body, directions) ->
    injector.registerFake 'axis', ['directions', (directions) ->
        @from_direction = directions.right
        return
    ]

    beforeAll add_instanceof_matcher
    afterAll () ->
        delete injector.fakes.axis
    describe 'Constructor', () ->
        it 'initializes properties', injector.inject ['body', (body) ->
            expect(body.dispatcher).toBeInstanceOf injector.getType('dispatcher')
            expect(body.canvas).toBeInstanceOf injector.getType('canvas')
            expect(body.context).toBeInstanceOf injector.getType('fake_context')
            expect(body.directions).toBeInstanceOf injector.getType('directions')
        ]

    describe 'Methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            body.dispatcher = dispatcher
        ]

        describe 'draw', () ->
            beforeEach injector.inject ['canvas', (canvas) ->
                body.canvas = canvas
                body.context = canvas.getContext('2d')
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
                head.position =
                    x: 20,
                    y: 50

                head.direction = directions.up;

                tail.position =
                    x: 20,
                    y: 10

                tail.direction = directions.up;

                body.from = tail;
                body.to = head;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
            ]

            it 'draws a horizontal line between axis and head', injector.inject ['axis', 'head', (axis, head) ->
                head.position =
                    x: 50,
                    y: 20

                head.direction = directions.right;

                axis.position =
                    x: 10,
                    y: 20

                axis.to_direction = directions.right;

                body.from = axis;
                body.to = head;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
            ]

            it 'draws a vertical line between axis and head', injector.inject ['axis', 'head', (axis, head) ->
                head.position =
                    x: 20,
                    y: 50

                head.direction = directions.up;

                axis.position =
                    x: 20,
                    y: 10

                axis.to_direction = directions.up;

                body.from = axis;
                body.to = head;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
            ]


            it 'draws a horizontal line between tail and axis', injector.inject ['tail', 'axis', (tail, axis) ->
                axis.position =
                    x: 50,
                    y: 20

                axis.from_direction = directions.right;

                tail.position =
                    x: 10,
                    y: 20

                tail.direction = directions.right;

                body.from = tail;
                body.to = axis;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
            ]

            it 'draws a vertical line between tail and axis', injector.inject ['tail', 'axis', (tail, axis) ->
                axis.position =
                    x: 20,
                    y: 50

                axis.from_direction = directions.up;

                tail.position =
                    x: 20,
                    y: 10

                tail.direction = directions.up;

                body.from = tail;
                body.to = axis;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
            ]

            it 'draws a horizontal line between axis and axis', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 50,
                    y: 20

                axis_to.from_direction = directions.right;

                axis_from.position =
                    x: 10,
                    y: 20

                axis_from.to_direction = directions.right;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 10, 20, 40, 10
            ]

            it 'draws a vertical line between axis and axis', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 20,
                    y: 50

                axis_to.from_direction = directions.up;

                axis_from.position =
                    x: 20,
                    y: 10

                axis_from.to_direction = directions.up;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledWith 20, 10, 10, 40
            ]

            it 'draws an upward vertical line that overlaps the map', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 20,
                    y: 20

                axis_to.from_direction = directions.up;

                axis_from.position =
                    x: 20,
                    y: 180

                axis_from.to_direction = directions.up;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledTwice()
                expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20
                expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 20

            ]

            it 'draws a downward vertical line that overlaps the map', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 20,
                    y: 180

                axis_to.from_direction = directions.down;

                axis_from.position =
                    x: 20,
                    y: 20

                axis_from.to_direction = directions.down;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledTwice()
                expect(body.context.fillRect).toHaveBeenCalledWith 20, 180, 10, 20
                expect(body.context.fillRect).toHaveBeenCalledWith 20, 0, 10, 20

            ]

            it 'draws a horizontal line to the right that overlaps the map', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 20,
                    y: 20

                axis_to.from_direction = directions.right;

                axis_from.position =
                    x: 180,
                    y: 20

                axis_from.to_direction = directions.right;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledTwice()
                expect(body.context.fillRect).toHaveBeenCalledWith 180, 20, 20, 10
                expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10
            ]


            it 'draws a horizontal line to the left that overlaps the map', injector.inject ['axis', 'axis', (axis_from, axis_to) ->
                axis_to.position =
                    x: 180,
                    y: 20

                axis_to.from_direction = directions.left;

                axis_from.position =
                    x: 20,
                    y: 20

                axis_from.to_direction = directions.left;

                body.from = axis_from;
                body.to = axis_to;

                body.draw()

                expect(body.context.fillRect).toHaveBeenCalledTwice()
                expect(body.context.fillRect).toHaveBeenCalledWith 180, 20, 20, 10
                expect(body.context.fillRect).toHaveBeenCalledWith 0, 20, 20, 10
            ]




        describe 'isLocatedAt', () ->
            it 'returns true if the passed position is contained within a horizontal line drawn to the left', () ->
                body.from =
                    position:
                        x: 20
                        y: 70
                    direction: directions.left
                body.to =
                    position:
                        x: 20
                        y: 20
                    direction: directions.left

                expect(body.isLocatedAt(x: 20, y: 50)).toBe true

            it 'returns true if the passed position is contained within a horizontal line drawn to the right', () ->
                body.to =
                    position:
                        x: 20
                        y: 70
                    direction: directions.right
                body.from =
                    position:
                        x: 20
                        y: 20
                    direction: directions.right

                expect(body.isLocatedAt(x: 20, y: 50)).toBe true

            it 'returns true if the passed position is contained within a vertical line drawn upwards', () ->
                body.from =
                    position:
                        x: 70
                        y: 20
                    direction: directions.up
                body.to =
                    position:
                        x: 20
                        y: 20
                    direction: directions.up

                expect(body.isLocatedAt(x: 50, y: 20)).toBe true

            it 'returns true if the passed position is contained within a vertical line drawn downwards', () ->
                body.to =
                    position:
                        x: 70
                        y: 20
                    direction: directions.down
                body.from =
                    position:
                        x: 20
                        y: 20
                    direction: directions.down

                expect(body.isLocatedAt(x: 50, y: 20)).toBe true

            it 'returns true if the passed position is on the upper border of the line', () ->
                body.to =
                    position:
                        x: 70
                        y: 20
                    direction: directions.down
                body.from =
                    position:
                        x: 20
                        y: 20
                    direction: directions.down

                expect(body.isLocatedAt(x: 70, y: 20)).toBe true

            it 'returns true if the passed position is on the lower border of the line', () ->
                body.to =
                    position:
                        x: 70
                        y: 20
                    direction: directions.down
                body.from =
                    position:
                        x: 20
                        y: 20
                    direction: directions.down

                expect(body.isLocatedAt(x: 20, y: 20)).toBe true

            it 'returns true if passed position is within the body`s girth', () ->
                body.to =
                    position:
                        x: 70
                        y: 20
                    direction: directions.down
                body.from =
                    position:
                        x: 20
                        y: 20
                    direction: directions.down

                expect(body.isLocatedAt(x: 20, y: 30)).toBe true

]
