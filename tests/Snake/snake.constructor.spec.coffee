snake_constructor_spec = injector.harness ['snake', (snake) ->
    it 'initializes correctly', () ->
        expect(snake.dispatcher).toBeInstanceOf injector.getType 'dispatcher'
        expect(snake.head).toBeInstanceOf injector.getType 'head'
        expect(snake.tail).toBeInstanceOf injector.getType 'tail'
        expect(snake.parts_factory).toBeInstanceOf injector.getType 'partsFactory'
]
