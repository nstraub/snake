axis_constructor_spec = () ->
    it 'initializes properties properly', injector.harness ['axis', (axis) ->
        expect(axis.area).toBeInstanceOf injector.getType('area')
        expect(axis.context).toBeInstanceOf injector.getType('fake_context')
    ]
