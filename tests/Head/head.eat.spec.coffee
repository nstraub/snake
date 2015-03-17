head_eat_spec = injector.inject ['head', (head) ->
    it 'grows when it eats an apple', injector.harness ['apple', (apple) ->
        head.eat apple

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'grow'
    ]

    it 'does nothing when it eats nothing', () ->
        head.eat()

        expect(head.dispatcher.trigger).not.toHaveBeenCalled()

    it 'dies when it eats a body part', injector.harness ['body', (body) ->
        head.eat(body)

        expect(head.dispatcher.trigger).toHaveBeenCalledWith 'die'
    ]
]
