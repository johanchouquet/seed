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

    // Top menu view
    topMenuView: {
        render: {
            template: {
                module: 'text!app/top-menu.html'
            },
            css: {
                module: 'css!app/top-menu.css'
            }
        },
        insert: {
            at: {
                $ref: 'dom.first!.top-menu',
                at: 'layout'
            }
        }
    },

    // Left nav view
    leftNavView: {
        render: {
            template: {
                module: 'text!app/left-nav.html'
            },
            css: {
                module: 'css!app/left-nav.css'
            }
        },
        insert: {
            at: {
                $ref: 'dom.first!.left-nav',
                at: 'layout'
            }
        }
    },

    // Main body view
    mainContentView: {
        render: {
            template: {
                module: 'text!app/main-content.html'
            },
            css: {
                module: 'css!app/main-content.css'
            }
        },
        insert: {
            at: {
                $ref: 'dom.first!.main-content',
                at: 'layout'
            }
        }
    },

    plugins: ['wire/dom', 'wire/dom/render']

});
