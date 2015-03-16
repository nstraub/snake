head_enqueue_direction_change_spec = injector.harness ['head', 'directions', (head, directions) ->
    beforeEach () ->
        sinon.stub head, 'changeDirection'

    afterEach () ->
        head.changeDirection.restore()

    it 'changes direction when head not currently changing direction', () ->
        head.changing_direction = false;
        head.enqueueDirectionChange(directions.up)

        expect(head.changeDirection).toHaveBeenCalledOnce()
        expect(head.changeDirection).toHaveBeenCalledWith directions.up

    it 'adds a new direction change to the queue when head changing direction', () ->
        head.changing_direction = true

        head.enqueueDirectionChange(directions.up)

        expect(head.changeDirection).not.toHaveBeenCalled()
        expect(head.direction_change_queue.length).toBe 1
        expect(head.direction_change_queue[0]).toBe directions.up
]
