head_eat_spec = injector.inject ['head', (head) ->
    it 'dies when it eats a wall', injector.inject ['wall', (wall) ->
        head.eat wall

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'die'
    ]

    it 'grows when it eats an apple', injector.inject ['apple', (apple) ->
        head.eat apple

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'grow'
    ]

    it 'does nothing when it eats nothing', () ->
        head.eat()

        expect(head.dispatcher.trigger).not.toHaveBeenCalled()

    it 'dies when it eats a body part', injector.inject ['body', (body) ->
        head.eat(body)

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'die'
    ]
]
