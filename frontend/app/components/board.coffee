define
    root: null

    $exports: $ref: 'api'

    api:
        create:
            module: 'app/components/Api'

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

        init: "init"

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]

