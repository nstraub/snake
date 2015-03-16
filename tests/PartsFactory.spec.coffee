describe 'Parts Factory', injector.inject ['partsFactory', (parts_factory) ->
    beforeAll add_instanceof_matcher

    describe 'methods', () ->
        it 'can create a body', injector.inject ['head', 'tail', (head, tail) ->
            body = parts_factory.createBody tail, head

            expect(body).toBeInstanceOf injector.getType 'body'
            expect(body.from).toBe tail
            expect(body.to).toBe head
        ]

        it 'can create an axis', injector.inject ['directions', (directions) ->
            axis_position = {x: 20, y: 20}
            axis = parts_factory.createAxis axis_position, directions.right, directions.up

            expect(axis.position).not.toBe axis_position
            expect(axis.position).toEqual axis_position
        ]
]
