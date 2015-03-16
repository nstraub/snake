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

    describe 'constructor', () ->
        it 'initializes correctly', () ->
            expect(tail.dispatcher).toBeInstanceOf injector.getType 'dispatcher'
            expect(tail.area).toBeInstanceOf injector.getType 'area'


    describe 'methods', () ->
        beforeEach injector.inject ['dispatcher', (dispatcher) ->
            tail.dispatcher = dispatcher
        ]

        describe 'draw', () ->
            beforeEach injector.harness ['area', (area) ->
                tail.area = area
                tail.context = area.getContext('2d')
            ]

            it 'places itself on the area at the specified position', () ->
                tail.position = x: 10, y: 10
                tail.draw();

                expect(tail.area.fake_context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10

        describe 'follow', injector.harness ['directions', (directions) ->
            it 'changes direction to head`s direction when following head', injector.harness ['head', (head) ->
                tail.follow head

                expect(tail.direction).toBe directions.right
            ]

            it 'changes direction to follow axis`s from_direction when following axis', injector.harness ['axis', (axis) ->
                tail.follow axis

                expect(tail.direction).toBe directions.right
            ]

            it 'registers the part being followed', injector.harness ['head', (head) ->
                tail.follow head

                expect(tail.following).toBe head
            ]
        ]


]
