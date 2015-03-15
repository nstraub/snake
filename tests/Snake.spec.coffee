describe 'snake', () ->
    injector.registerFake 'partsFactory', () ->
        @createBody = sinon.stub()
        @createBody.returns('test body')
        return


    afterAll () ->
        delete injector.fakes.partsFactory

    describe 'object', injector.harness ['snake', (snake) ->
        beforeAll add_instanceof_matcher

        describe 'constructor', () ->
            it 'initializes correctly', () ->
                expect(snake.dispatcher).toBeInstanceOf injector.getType 'dispatcher'
                expect(snake.head).toBeInstanceOf injector.getType 'head'
                expect(snake.tail).toBeInstanceOf injector.getType 'tail'
                expect(snake.parts_factory).toBeInstanceOf injector.getType 'partsFactory'

        describe 'methods', () ->
            beforeEach injector.inject ['dispatcher', (dispatcher) ->
                snake.dispatcher = dispatcher
            ]

            describe 'initialize', () ->
                beforeEach () ->
                    sinon.spy(snake.tail, 'follow')
                    snake.initialize {x: 60, y: 10}, 4

                afterEach () ->
                    snake.tail.follow.restore()
                    snake.bodies = []
                    delete snake.head.position
                    delete snake.tail.position

                it 'sets positions of head and tail correctly', () ->
                    expect(snake.head.position.x).toBe 60
                    expect(snake.head.position.y).toBe 10

                    expect(snake.tail.position.x).toBe 20
                    expect(snake.tail.position.y).toBe 10
                it 'sets tail to follow head', () ->
                    expect(snake.tail.follow).toHaveBeenCalledWith snake.head

                it 'registers a draw event on the dispatcher', () ->
                    expect(snake.dispatcher.on).toHaveBeenCalledWith 'draw', snake.draw

                it 'creates a body from head to tail', () ->
                    expect(snake.parts_factory.createBody).toHaveBeenCalledWith snake.tail, snake.head
                    expect(snake.bodies[0]).toBe 'test body'

            describe 'draw', () ->
                beforeEach () ->
                    sinon.stub snake.head, 'draw'
                    sinon.stub snake.tail, 'draw'

                afterEach () ->
                    snake.head.draw.restore()
                    snake.tail.draw.restore()
                    snake.bodies = []

                it 'draws the snake on screen', () ->
                    snake.bodies = [draw: sinon.spy()]

                    snake.draw()

                    expect(snake.head.draw).toHaveBeenCalledOnce()
                    expect(snake.tail.draw).toHaveBeenCalledOnce()
                    expect(snake.bodies[0].draw).toHaveBeenCalledOnce()

                it 'draws all body parts', () ->
                    draw_spy = sinon.spy()
                    snake.bodies = [{draw: draw_spy}, {draw: draw_spy}]

                    snake.draw()

                    expect(draw_spy).toHaveBeenCalledTwice()

                it 'clears the canvas first', () ->
                    snake.draw()

                    expect(snake.dispatcher.trigger).toHaveBeenCalledWith 'clear'
                    expect(snake.dispatcher.trigger).toHaveBeenCalledBefore snake.head.draw
                    expect(snake.dispatcher.trigger).toHaveBeenCalledBefore snake.tail.draw

    ]
