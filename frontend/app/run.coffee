`(function(curl){`

cjsLoader = moduleLoader: 'curl/loader/cjsm11'

config =
    paths:
        'jquery': 'lib/jquery/jquery'
    packages: [
        { name: 'curl', location: 'lib/curl/src/curl' }
        { name: 'knockout', location: 'lib/knockout/build/output', main: 'knockout-latest' }
    ]
    preloads: ['app/utils/jquery-setup']

curl(config, [
    'knockout'
], (ko) ->


    class ViewModel
        constructor: ->
            @TL = ko.observable('X')
            @TM = ko.observable('X')
            @TR = ko.observable('X')

        clickBR: (viewModel, event) ->
            console.log 'clicked', event.target

    ko.applyBindings new ViewModel()

)

`})(curl)`
