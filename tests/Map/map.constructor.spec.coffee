map_constructor_spec = () ->
    beforeAll add_instanceof_matcher
    beforeEach () ->
        sinon.stub injector.getType('map').prototype, 'clear'

    afterEach () ->
        injector.getType('map').prototype.clear.restore()

    it 'initializes properties correctly', injector.inject ['area', 'dispatcher', (area, dispatcher) ->
        map = new (injector.getType('map'))(area, dispatcher)

        expect(map.area).toBeInstanceOf injector.getType('area')
        expect(map.context).toBeInstanceOf injector.getType('fake_context')
        expect(map.dispatcher).toBeInstanceOf injector.getType('dispatcher')
        expect(map.dispatcher.on).toHaveBeenCalledWith 'clear'

        map.dispatcher.on.args[0][1]()

        expect(map.clear).toHaveBeenCalledOn map
    ]
