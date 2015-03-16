head_change_direction_spec = injector.inject ['directions', 'head', (directions, head) ->
    afterEach () ->
        head.direction = directions.right

    it 'changes the direction property of the head', () ->
        head.changeDirection directions.up

    it 'informs the direction change to the rest of the app', () ->
        head.changeDirection directions.up

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'changed:direction', directions.right, directions.up

    it 'doesn`t change direction when passed direction is equal to current direction', () ->
        head.changeDirection directions.right

        expect(head.dispatcher.trigger).not.toHaveBeenCalled()

    it 'sets changing directions flag', () ->
        head.changeDirection directions.up

        expect(head.changing_direction).toBe true
]
