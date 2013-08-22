define
    # Injected - element to inject boardView into
    root: null
    # Injected - for notifying of turns finishing etc
    gameManager: null

    # Doesn't work for some reason when using child
    # contexts, should mean only the api object is exposed
    $exports: $ref: 'api'

    # Sent all external calls through this Api object
    # as ideally only this is exposed.
    api:
        create:
            module: 'app/components/board/Api'
        properties:
            _board: $ref: 'boardViewmodel'
        connect:
            startTurn: 'boardViewmodel.startTurn'
            highlight: 'boardViewmodel.highlight'
            _turnFinished: 'gameManager.turnFinished'
        after:
            'boardViewmodel.turnFinished': 'turnFinished'

    boardView:
        render:
            template:
                module: 'text!app/components/board/views/board.html'
            css:
                module: 'css!app/components/board/views/board.css'
        insert:
            last:
                $ref: 'root'

    boardViewmodel:
        create:
            module: 'app/components/board/viewmodels/Board'
            args: [
                $ref: "boardView"
            ]

        ready: "init"

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/aop' }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]

