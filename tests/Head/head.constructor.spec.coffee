head_constructor_spec = injector.inject ['directions', (directions) ->
    _head = null
    beforeEach injector.inject ['dispatcher', 'area', (dispatcher, area) ->
        sinon.stub(injector.getType('head').prototype, 'enqueueDirectionChange')
        _head = new (injector.getType('head'))(dispatcher, area, directions)
    ]

    afterEach () ->
        injector.getType('head').prototype.enqueueDirectionChange.restore()

    it 'properly initializes properties', () ->

        expect(_head.dispatcher).toBeInstanceOf injector.getType('dispatcher')
        expect(_head.area).toBeInstanceOf injector.getType('area')
        expect(_head.context).toBeInstanceOf injector.getType('fake_context')
        expect(_head.directions).toBeInstanceOf injector.getType('directions')
        expect(_head.direction).toBe directions.right
        expect(_head.dispatcher.on).toHaveBeenCalledWith 'change:direction'

        _head.dispatcher.on.args[0][1](1)

        expect(_head.enqueueDirectionChange).toHaveBeenCalledOn _head
        expect(_head.enqueueDirectionChange).toHaveBeenCalledWith 1
]
