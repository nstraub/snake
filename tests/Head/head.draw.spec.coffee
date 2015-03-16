head_draw_spec = injector.inject ['head', (head) ->
    beforeEach injector.inject ['area', (area) ->
        head.area = area
        head.context = area.getContext('2d')
    ]

    it 'places itself on the area at the specified position', () ->
        head.position = x: 10, y: 10
        head.draw();

        expect(head.area.fake_context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10
]
