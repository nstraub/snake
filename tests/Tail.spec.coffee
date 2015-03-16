describe 'Tail', injector.harness ['tail', (tail) ->
    beforeAll () ->
        injector.registerFake 'head', ['directions', (directions) ->
            @direction = directions.right
            return
        ]

        injector.registerFake 'axis', ['directions', (directions) ->
            @from_direction = directions.right
            return
        ]

    beforeAll add_instanceof_matcher

    afterAll () ->
        delete injector.fakes.head;
        delete injector.fakes.axis;

    describe 'constructor', tail_constructor_spec


    describe 'methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            tail.dispatcher = dispatcher
        ]

        describe 'draw', tail_draw_spec

        describe 'follow', tail_follow_spec


]
