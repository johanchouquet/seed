define
    hello: 'internet'

    view:
        render:
            template:
                module: 'text!app/views/example.html'
            css:
                module: 'css!app/views/example.css'
        insert:
            at:
                $ref: 'dom.first!body'

    viewmodel:
        create:
            module: 'app/viewmodels/Example'
            args: [
                $ref: "view"
            ]

        init: "init"

    plugins: [
        # { module: 'wire/debug', trace: false }
        { module: 'wire/dom' }
        { module: 'wire/dom/render' }
        { module: 'wire/connect'}
    ]
