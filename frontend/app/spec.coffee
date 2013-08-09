define
    hello: 'internet'

    layout:
        render:
            template:
                module: 'text!app/views/layout.html'
            css:
                module: 'css!app/views/layout.css'

        insert:
            at:
                $ref: 'dom.first!body'

    boardView:
        render:
            template:
                module: 'text!app/views/board.html'
            css:
                module: 'css!app/views/board.css'
        insert:
            at:
                $ref: 'dom.first!.board-TL'
                at: 'layout'

    boardFactory:
        create:
            module: 'app/BoardFactory'

        properties:
            _boardLocation: null
            _makeBoard:
                wire:
                    defer: true
                    spec: 'app/components/board'
                    provide:
                        root: $ref: 'boardFactory._boardLocation'
                connect:
                    'won': 'boardFactory.wonBoard'

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]
