define
    # Page layout. Defines container for the boards
    layout:
        render:
            template:
                module: 'text!app/views/layout.html'
            css:
                module: 'css!app/views/layout.css'

        insert:
            at:
                $ref: 'dom.first!body'

    # Generates all the boards from the board spec
    boardFactory:
        create:
            module: 'app/BoardFactory'

        properties:
            # Inject the node in which to add board element
            _layout: $ref: 'layout'
            # Inject a method which will run the board spec.
            # This will create an instance of the board component.
            _makeBoard:
                wire:
                    defer: true
                    spec: 'app/components/board/spec'
                    provide:
                        gameManager: $ref: 'gameManager'

        # Connect some of these methods to gameManager
        connect:
            # Note the method naming, the board factory emits a 'boardCreated'
            # event effectively, which we connect to the 'registerBoard'
            # input of the gameManager. This means they are even decoupled
            # by name.
            '_boardCreated': 'gameManager.registerBoard'
            '_allBoardsCreated': 'gameManager.start'

        # Runs 'setupBoards' when this component is ready and
        # starts off the app!
        ready: 'setupBoards'

    # Controls flow of game
    gameManager:
        create:
            module: 'app/Game'

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]
