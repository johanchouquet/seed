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

    gameManager:
        create:
            module: 'app/Game'

    boardFactory:
        create:
            module: 'app/BoardFactory'

        properties:
            _layout: $ref: 'layout'
            _boardLocation: null
            _makeBoard:
                wire:
                    defer: true
                    spec: 'app/components/board'
                    provide:
                        root: $ref: 'boardFactory._boardLocation'
                        gameManager: $ref: 'gameManager'

        connect:
            '_boardCreated': 'gameManager.registerBoard'
            '_boardsCreated': 'gameManager.start'

        ready: 'setupBoards'


    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]
