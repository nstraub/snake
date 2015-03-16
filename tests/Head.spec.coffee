describe 'Head', injector.inject ['head', (head) ->
    beforeAll add_instanceof_matcher

    injector.registerFake 'apple', ->
        return
    injector.registerFake 'wall', ->
        return
    injector.registerFake 'body', ->
        return

    afterAll () ->
        delete injector.fakes.apple
        delete injector.fakes.wall
        delete injector.fakes.body

    describe 'constructor', head_constructor_spec

    describe 'Methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            head.dispatcher = dispatcher
        ]

        describe 'eat', head_eat_spec

        describe 'draw', head_draw_spec

        describe 'changeDirection', head_change_direction_spec

        describe 'enqueueDirectionChange', head_enqueue_direction_change_spec
]
