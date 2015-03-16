head_constructor_spec = () ->
    it 'properly initializes properties', injector.inject ['dispatcher', 'area', 'directions', (dispatcher, area, directions) ->
        _head = new (injector.getType('head'))(dispatcher, area, directions)

        expect(_head.dispatcher).toBeInstanceOf injector.getType('dispatcher')
        expect(_head.area).toBeInstanceOf injector.getType('area')
        expect(_head.context).toBeInstanceOf injector.getType('fake_context')
        expect(_head.directions).toBeInstanceOf injector.getType('directions')
        expect(_head.direction).toBe directions.right
    ]
