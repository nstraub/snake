located_at_spec = injector.inject ['body', 'directions', (body, directions) ->
    it 'returns true if the passed position is contained within a horizontal line drawn to the left', () ->
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

        expect(body.isLocatedAt(x: 20, y: 30)).toBe true
]
