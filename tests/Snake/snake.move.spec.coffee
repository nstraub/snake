snake_move_spec = injector.harness ['directions', 'snake', (directions, snake) ->
    beforeEach injector.inject ['head', 'tail', (head, tail) ->
        head.position =
            x: 50, y: 50
        tail.position =
            x: 50, y: 50

        head.direction = directions.up
        tail.direction = directions.up

        sinon.stub head, 'changeDirection'
    ]

    afterEach injector.inject ['head', (head) ->
        head.changeDirection.restore()
    ]

    it 'moves head when it is pointing right', () ->
        snake.head.direction = directions.right
        snake.move()
        expect(snake.head.position.x).toBe 60
    it 'moves head when it is pointing left', () ->
        snake.head.direction = directions.left
        snake.move()
        expect(snake.head.position.x).toBe 40
    it 'moves tail when it is pointing right', () ->
        snake.tail.direction = directions.right
        snake.move()
        expect(snake.tail.position.x).toBe 60
    it 'moves tail when it is pointing left', () ->
        snake.tail.direction = directions.left
        snake.move()
        expect(snake.tail.position.x).toBe 40
    it 'moves head when it is pointing up', () ->
        snake.move()
        expect(snake.head.position.y).toBe 40
    it 'moves head when it is pointing down', () ->
        snake.head.direction = directions.down
        snake.move()
        expect(snake.head.position.y).toBe 60
    it 'moves tail when it is pointing up', () ->
        snake.move()
        expect(snake.tail.position.y).toBe 40
    it 'moves tail when it is pointing down', () ->
        snake.tail.direction = directions.down
        snake.move()
        expect(snake.tail.position.y).toBe 60

    it 'wraps movement when pointing up and new position is outside area', () ->
        snake.head.position.y = 0;
        snake.move()

        expect(snake.head.position.y).toBe 190

    it 'wraps movement when pointing down and new position is outside area', () ->
        snake.head.direction = directions.down
        snake.head.position.y = 190;
        snake.move()

        expect(snake.head.position.y).toBe 0

    it 'wraps movement when pointing left and new position is outside area', () ->
        snake.head.direction = directions.left
        snake.head.position.x = 0;
        snake.move()

        expect(snake.head.position.x).toBe 190

    it 'wraps movement when pointing right and new position is outside area', () ->
        snake.head.direction = directions.right
        snake.head.position.x = 190;
        snake.move()

        expect(snake.head.position.x).toBe 0

    it 'changes head`s direction when direction queue still has elments', () ->
        snake.head.direction_change_queue.push(directions.right)

        snake.move()

        expect(snake.head.changeDirection).toHaveBeenCalledOnce()
        expect(snake.head.changeDirection).toHaveBeenCalledWith(directions.right)

    it 'sets head`s direction change flag when direction queue no longer has elments', () ->
        snake.head.direction_change_queue = []
        snake.head.changing_direction = true

        snake.move()

        expect(snake.head.changeDirection).not.toHaveBeenCalled()
        expect(snake.head.changing_direction).toBe false

]
