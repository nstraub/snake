describe 'Body', injector.inject ['body', 'directions', (body, directions) ->
    injector.registerFake 'axis', ['directions', (directions) ->
        @from_direction = directions.right
        return
    ]

    beforeAll add_instanceof_matcher
    afterAll () ->
        delete injector.fakes.axis
    describe 'Constructor', body_constructor_spec

    describe 'Methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            body.dispatcher = dispatcher
        ]

        describe 'draw', body_draw_spec

        describe 'isLocatedAt', located_at_spec

]
