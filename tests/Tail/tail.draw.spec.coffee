tail_draw_spec = injector.harness ['tail', (tail) ->
    beforeEach injector.inject ['area', (area) ->
        tail.area = area
        tail.context = area.getContext('2d')
    ]

    it 'places itself on the area at the specified position', () ->
        tail.position =
            x: 10, y: 10
        tail.draw();

        expect(tail.area.fake_context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10
]
