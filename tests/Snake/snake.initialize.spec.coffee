snake_initialize_spec = injector.harness ['snake', (snake) ->
    beforeEach injector.inject ['dispatcher', (dispatcher) ->
        sinon.spy(snake.tail, 'follow')
        sinon.stub(snake, 'draw')

        snake.dispatcher = dispatcher

        snake.initialize {x: 60, y: 10}, 4
    ]
    
    afterEach () ->
        snake.tail.follow.restore()
        snake.draw.restore()
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
        expect(snake.dispatcher.on).toHaveBeenCalledWith 'draw'
        snake.dispatcher.on.args[0][1]()

        expect(snake.draw).toHaveBeenCalledOn snake

    it 'creates a body from head to tail', () ->
        expect(snake.parts_factory.createBody).toHaveBeenCalledWith snake.tail, snake.head
        expect(snake.bodies[0]).toBe 'test body'
]
