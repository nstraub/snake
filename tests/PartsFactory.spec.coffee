describe 'Parts Factory', injector.inject ['partsFactory', (parts_factory) ->
    beforeAll add_instanceof_matcher

    describe 'methods', () ->
        it 'can create a body', injector.inject ['head', 'tail', (head, tail) ->
            body = parts_factory.createBody tail, head

            expect(body).toBeInstanceOf injector.getType 'body'
            expect(body.from).toBe tail
            expect(body.to).toBe head
        ]
]
