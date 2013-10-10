define({
    // Normalise browser environment using normalize.css
    reset: {
        module: 'css!lib/normalize-css/normalize.css'
    },

    // Create basic layout
    layout: {
        render: {
            template: {
                module: 'text!app/layout.html'
            },
            css: {
                module: 'css!app/layout.css'
            }
        },
        insert: {
            at: {
                $ref: 'dom.first!body'
            }
        }
    },

    // Backbone email collection
    emailPreviewCollection: {
        create: {
            module: 'app/EmailPreviewsCollection'
        },
        properties: {
            url: 'app/emailPreviews.json'
        },
        ready: 'fetch'
    },

    plugins: ['wire/dom', 'wire/dom/render']

});
