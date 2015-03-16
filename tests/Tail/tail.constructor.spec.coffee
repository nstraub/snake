tail_constructor_spec = () ->
    it 'initializes correctly', injector.inject ['dispatcher', 'area', (dispatcher, area) ->
        tail = new (injector.getType('tail'))(dispatcher, area)
        expect(tail.dispatcher).toBeInstanceOf injector.getType 'dispatcher'
        expect(tail.area).toBeInstanceOf injector.getType 'area'
    ]
