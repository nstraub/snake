snake_grow_spec = injector.harness ['directions', 'snake', 'apple', (directions, snake, apple) ->
    beforeEach injector.inject ['head', 'tail', (head, tail) ->
        head.position = x: 50, y: 50
        tail.position = x: 50, y: 50

        head.direction = directions.up
        tail.direction = directions.up

        sinon.stub apple, 'reposition'
    ]

    afterEach () ->
        apple.reposition.restore()

    it 'moves just the head', () ->
        snake.grow();

        expect(snake.head.position.x).toBe 50
        expect(snake.head.position.y).toBe 40
        expect(snake.tail.position.x).toBe 50
        expect(snake.tail.position.y).toBe 50

    it 'repositions the apple', () ->
        snake.grow();

        expect(apple.reposition).toHaveBeenCalledOnce()
]
