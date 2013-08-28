`(function(curl){`

cjsLoader = moduleLoader: 'curl/loader/cjsm11'

config =
    paths:
        'jquery': 'lib/jquery/jquery'
    packages: [
        { name: 'curl', location: 'lib/curl/src/curl' }
        { name: 'underscore', location: 'lib/lodash/dist', main: 'lodash.compat'}
        { name: 'lodash', location: 'lib/lodash/dist', main: 'lodash.compat'}
        { name: 'knockout', location: 'lib/knockout/build/output', main: 'knockout-latest' }
        { name: 'backbone', location: 'lib/backbone', main: 'backbone', config: cjsLoader }

    ]
    preloads: ['app/utils/jquery-setup']

success = ->
    console.log 'App started!'

fail = (error) ->
    console.error 'App failed to start'
    console.error error.stack

curl(config, ['app/main']).then success, fail

`})(curl)`
