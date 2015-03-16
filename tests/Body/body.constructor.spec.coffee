body_constructor_spec = () ->
    it 'initializes properties', injector.inject ['body', (body) ->
        expect(body.dispatcher).toBeInstanceOf injector.getType('dispatcher')
        expect(body.area).toBeInstanceOf injector.getType('area')
        expect(body.context).toBeInstanceOf injector.getType('fake_context')
        expect(body.directions).toBeInstanceOf injector.getType('directions')
    ]
