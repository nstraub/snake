tail_follow_spec = injector.harness ['directions', 'tail', (directions, tail) ->
    it 'changes direction to head`s direction when following head', injector.harness ['head', (head) ->
        tail.follow head

        expect(tail.direction).toBe directions.right
    ]

    it 'changes direction to follow axis`s from_direction when following axis', injector.harness ['axis',
        (axis) ->
            tail.follow axis

            expect(tail.direction).toBe directions.right
    ]

    it 'registers the part being followed', injector.harness ['head', (head) ->
        tail.follow head

        expect(tail.following).toBe head
    ]
]
