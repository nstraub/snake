snake_draw_spec = injector.harness ['snake', (snake) ->
    beforeEach () ->
        sinon.stub snake.head, 'draw'
        sinon.stub snake.tail, 'draw'

    afterEach () ->
        snake.head.draw.restore()
        snake.tail.draw.restore()
        snake.bodies = []

    it 'draws the snake on screen', () ->
        snake.bodies = [
            draw: sinon.spy()
        ]

        snake.draw()

        expect(snake.head.draw).toHaveBeenCalledOnce()
        expect(snake.tail.draw).toHaveBeenCalledOnce()
        expect(snake.bodies[0].draw).toHaveBeenCalledOnce()

    it 'draws all body parts', () ->
        draw_spy = sinon.spy()
        snake.bodies = [
            {draw: draw_spy},
            {draw: draw_spy}
        ]

        snake.draw()

        expect(draw_spy).toHaveBeenCalledTwice()

    it 'clears the area first', () ->
        snake.draw()

        expect(snake.dispatcher.trigger).toHaveBeenCalledWith 'clear'
        expect(snake.dispatcher.trigger).toHaveBeenCalledBefore snake.head.draw
        expect(snake.dispatcher.trigger).toHaveBeenCalledBefore snake.tail.draw
]
