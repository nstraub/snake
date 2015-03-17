snake_initialize_spec = injector.harness ['snake', (snake) ->
    beforeEach injector.inject ['dispatcher', 'partsFactory', (dispatcher, parts_factory) ->
        sinon.spy(snake.tail, 'follow')

        snake.dispatcher = dispatcher
        snake.parts_factory = parts_factory

        parts_factory.createBody.returns('test body')

        snake.initialize {x: 60, y: 10}, 4
    ]
    
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


    it 'creates a body from head to tail', () ->
        expect(snake.parts_factory.createBody).toHaveBeenCalledWith snake.tail, snake.head
        expect(snake.bodies[0]).toBe 'test body'
]
