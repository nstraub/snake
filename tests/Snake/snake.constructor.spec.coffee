snake_constructor_spec = () ->

    snake = null
    beforeEach injector.inject ['dispatcher', 'head', 'tail', 'partsFactory', 'directions', 'area', 'map', (dispatcher, head, tail, parts_factory, directions, area, map) ->
        sinon.stub injector.getType('snake').prototype, 'draw'
        sinon.stub injector.getType('snake').prototype, 'addAxis'
        snake = new (injector.getType('snake'))(dispatcher, head, tail, parts_factory, directions, area, map)
    ]

    afterEach () ->
        injector.getType('snake').prototype.draw.restore()
        injector.getType('snake').prototype.addAxis.restore()

    it 'initializes correctly', () ->
        expect(snake.dispatcher).toBeInstanceOf injector.getType 'dispatcher'
        expect(snake.head).toBeInstanceOf injector.getType 'head'
        expect(snake.tail).toBeInstanceOf injector.getType 'tail'
        expect(snake.parts_factory).toBeInstanceOf injector.getType 'partsFactory'
        expect(snake.map).toBeInstanceOf injector.getType 'map'

    it 'registers a draw event on the dispatcher', () ->
        expect(snake.dispatcher.on).toHaveBeenCalledWith 'draw'
        snake.dispatcher.on.args[0][1]()

        expect(snake.draw).toHaveBeenCalledOn snake

    it 'registers a changed:direction event on the dispatcher', () ->
        expect(snake.dispatcher.on).toHaveBeenCalledWith 'changed:direction'
        snake.dispatcher.on.args[1][1](0, 0)

        expect(snake.addAxis).toHaveBeenCalledOn snake
        expect(snake.addAxis).toHaveBeenCalledWith 0, 0
