(function(curl){

    // Configure all our module paths
    var config = {
        paths: {
            'jquery': 'lib/jquery/jquery'
        },
        packages: [
            { name: 'curl', location: 'lib/curl/src/curl' },
            { name: 'wire', location: 'lib/wire', main: 'wire' },
            { name: 'meld', location: 'lib/meld', main: 'meld' },
            { name: 'when', location: 'lib/when', main: 'when' },
            { name: 'poly', location: 'lib/poly' },
            { name: 'backbone', location: 'lib/backbone', main: 'backbone',
                config: {loader: 'curl/loader/cjsm11'}
            },
            { name: 'underscore', location: 'lib/lodash/dist', main: 'lodash.min'}
        ],
        preloads: ['jquery']
    };

    // If our app starts correctly then log and make the context available
    var success = function (context) {
        console.log('Spec loading OK! Context available as \'context\'');
        window.context = context;
    };

    // If something goes wrong then we log that error
    var fail = function (error) {
        console.log('Error loading spec');
        console.error(error.stack);
    };

    // Start up the app! Runs our app/spec.js through wire. Curl is
    // promise-based so we can pass the result to our success/failure handlers
    curl(config, ['wire!app/spec']).then(success, fail);

})(curl);
