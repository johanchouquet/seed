define
    # Injected
    root: null
    gameManager: null

    api:
        create:
            module: 'app/components/Api'
        connect:
            startTurn: 'boardViewmodel.startTurn'
            _turnFinished: 'gameManager.turnFinished'
            highlight: 'boardViewmodel.highlight'

    boardView:
        render:
            template:
                module: 'text!app/views/board.html'
            css:
                module: 'css!app/views/board.css'
        insert:
            at:
                $ref: 'root'

    boardViewmodel:
        create:
            module: 'app/viewmodels/Board'
            args: [
                $ref: "boardView"
            ]

        ready: "init"
        after:
            turnFinished: 'api.turnFinished'

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/aop' }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]

