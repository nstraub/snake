describe 'Head', injector.inject ['head', (head) ->
    beforeAll add_instanceof_matcher

    injector.registerFake 'apple', ->
        return
    injector.registerFake 'wall', ->
        return
    injector.registerFake 'body', ->
        return

    afterAll () ->
        delete injector.fakes.apple
        delete injector.fakes.wall
        delete injector.fakes.body

    describe 'constructor', () ->
        it 'properly initializes properties', injector.inject ['directions', (directions) ->
            expect(head.dispatcher).toBeInstanceOf injector.getType('dispatcher')
            expect(head.canvas).toBeInstanceOf injector.getType('canvas')
            expect(head.context).toBeInstanceOf injector.getType('fake_context')
            expect(head.directions).toBeInstanceOf injector.getType('directions')
            expect(head.direction).toBe directions.right
        ]

    describe 'Methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            head.dispatcher = dispatcher
        ]

        describe 'eat', () ->
            it 'dies when it eats a wall', injector.inject ['wall', (wall) ->
                head.eat wall

                expect(head.dispatcher.trigger).toHaveBeenCalledWith 'die'
            ]

            it 'grows when it eats an apple', injector.inject ['apple', (apple) ->
                head.eat apple

                expect(head.dispatcher.trigger).toHaveBeenCalledWith 'grow'
            ]

            it 'does nothing when it eats nothing', () ->
                head.eat()

                expect(head.dispatcher.trigger).not.toHaveBeenCalled()

            it 'dies when it eats a body part', injector.inject ['body', (body) ->
                head.eat(body)

                expect(head.dispatcher.trigger).toHaveBeenCalledWith 'die'
            ]

        describe 'draw', () ->
            beforeEach injector.inject ['canvas', (canvas) ->
                head.canvas = canvas
                head.context = canvas.getContext('2d')
            ]

            it 'places itself on the canvas at the specified position', () ->
                head.draw({x: 10, y: 10});

                expect(head.canvas.fake_context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10

        describe 'changeDirection', injector.inject ['directions', (directions) ->
            afterEach () ->
                head.direction = directions.right

            it 'changes the direction property of the head', () ->
                head.changeDirection directions.up

            it 'informs the direction change to the rest of the app', () ->
                head.changeDirection directions.up

                expect(head.dispatcher.trigger).toHaveBeenCalledWith 'change:direction', directions.right, directions.up
        ]
]
