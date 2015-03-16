head_change_direction_spec = injector.inject ['directions', 'head', (directions, head) ->
    afterEach () ->
        head.direction = directions.right

    it 'changes the direction property of the head', () ->
        head.changeDirection directions.up

    it 'informs the direction change to the rest of the app', () ->
        head.changeDirection directions.up

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'change:direction', directions.right, directions.up
]
