map_get_item_at_spec = injector.inject ['map', (map) ->
    it 'returns apple if apple is at position', () ->
        map.apple.x = 10
        map.apple.y = 10

        result = map.getItemAt(10, 10)

        expect(result).toBe map.apple

    it 'returns null if apple is not at position', () ->
        result = map.getItemAt(15, 15)

        expect(result).toBeNull()
]
