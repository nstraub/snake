axis_draw_spec = () ->
    it 'places itself on the area at the specified position', injector.inject ['axis', (axis) ->
        axis.position = x: 10, y: 10
        axis.draw();

        expect(axis.area.fake_context.fillRect).toHaveBeenCalledWith 10, 10, 10, 10
    ]
