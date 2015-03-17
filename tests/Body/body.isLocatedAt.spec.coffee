located_at_spec = injector.inject ['body', 'directions', (body, directions) ->
    describe 'horizontal', () ->
        describe 'from tail', () ->
            beforeAll injector.inject ['head', 'tail', (head, tail) ->
                tail.position = x: 20, y: 20
                head.position = x: 60, y: 20
                head.direction = tail.direction = directions.right

                body.from = tail
                body.to = head
            ]

            it 'returns true when position is within bounds', () ->
                expect(body.isLocatedAt(x: 30, y: 20)).toBe true
            it 'returns true when position is on left end', () ->
                expect(body.isLocatedAt(x: 20, y: 20)).toBe true
            it 'returns true when position is on right end', () ->
                expect(body.isLocatedAt(x: 60, y: 20)).toBe true
            it 'returns false when position is out of bounds', () ->
                expect(body.isLocatedAt(x: 70, y: 40)).toBe false
            it 'returns false when position is directly on top', () ->
                expect(body.isLocatedAt(x: 40, y: 10)).toBe false
            it 'returns false when position is directly below', () ->
                expect(body.isLocatedAt(x: 50, y: 10)).toBe false

    ###it 'returns true if the passed position is contained within a horizontal line drawn to the left', () ->
        body.from =
            position: x: 20, y: 70
            direction: directions.left
        body.to =
            position: x: 20, y: 20
            direction: directions.left

        expect(body.isLocatedAt(x: 20, y: 50)).toBe true

    it 'returns true if the passed position is contained within a horizontal line drawn to the right', () ->
        body.to =
            position: x: 20, y: 70
            direction: directions.right
        body.from =
            position: x: 20, y: 20
            direction: directions.right

        expect(body.isLocatedAt(x: 20, y: 50)).toBe true

    it 'returns true if the passed position is contained within a vertical line drawn upwards', () ->
        body.from =
            position: x: 70, y: 20
            direction: directions.up
        body.to =
            position: x: 20, y: 20
            direction: directions.up

        expect(body.isLocatedAt(x: 50, y: 20)).toBe true

    it 'returns true if the passed position is contained within a vertical line drawn downwards', () ->
        body.to =
            position: x: 70, y: 20
            direction: directions.down
        body.from =
            position: x: 20, y: 20
            direction: directions.down

        expect(body.isLocatedAt(x: 50, y: 20)).toBe true

    it 'returns true if the passed position is on the upper border of the line', () ->
        body.to =
            position: x: 70, y: 20
            direction: directions.down
        body.from =
            position: x: 20, y: 20
            direction: directions.down

        expect(body.isLocatedAt(x: 70, y: 20)).toBe true

    it 'returns true if the passed position is on the lower border of the line', () ->
        body.to =
            position: x: 70, y: 20
            direction: directions.down
        body.from =
            position: x: 20, y: 20
            direction: directions.down

        expect(body.isLocatedAt(x: 20, y: 20)).toBe true

    it 'returns true if passed position is within the body`s girth', () ->
        body.to =
            position: x: 70, y: 20
            direction: directions.down
        body.from =
            position: x: 20, y: 20
            direction: directions.down

        expect(body.isLocatedAt(x: 20, y: 30)).toBe true###
]
