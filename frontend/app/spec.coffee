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

    exampleView:
        render:
            template:
                module: 'text!app/views/example.html'
            css:
                module: 'css!app/views/example.css'
        insert:
            after:
                $ref: 'layout'

    viewmodel:
        create:
            module: 'app/viewmodels/Example'
            args: [
                $ref: "exampleView"
            ]

        init: "init"

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]
