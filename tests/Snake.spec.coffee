describe 'snake', () ->
    injector.registerFake 'partsFactory', () ->
        @createBody = sinon.stub()
        @createAxis = sinon.stub()

        body = injector.instantiate('body')
        body.isLocatedAt = sinon.stub()
        @createBody.returns(body)
        return


    afterAll () ->
        delete injector.fakes.partsFactory

    describe 'object', injector.harness ['snake', (snake) ->
        beforeAll add_instanceof_matcher

        describe 'constructor', snake_constructor_spec

        describe 'methods', () ->
            beforeEach injector.inject ['dispatcher', (dispatcher) ->
                snake.dispatcher = dispatcher
            ]

            describe 'initialize', snake_initialize_spec

            describe 'draw', snake_draw_spec

            describe 'move', snake_move_spec

            describe 'grow', snake_grow_spec

            describe 'addAxis', snake_add_axis_spec
    ]
