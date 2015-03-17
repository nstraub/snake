map_clear_spec = injector.harness ['map', 'apple', (map, apple) ->
    beforeEach () ->
        sinon.stub apple, 'draw'
        sinon.stub apple, 'reposition'

    afterEach () ->
        apple.draw.restore()
        apple.reposition.restore()

    it 'clears the entire area', () ->
        map.clear()

        expect(map.context.clearRect).toHaveBeenCalledOnce()
        expect(map.context.clearRect).toHaveBeenCalledWith 0, 0, 200, 200

    it 'redraws the apple', () ->
        apple.x = true
        map.clear()

        expect(apple.draw).toHaveBeenCalledOnce()
        expect(apple.reposition).not.toHaveBeenCalled()

    it 'repositions the apple if it has no position', () ->
        apple.x = false
        map.clear()

        expect(apple.reposition).toHaveBeenCalledOnce()
]
