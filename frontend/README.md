Frontend Structure
==================

The Django backend serves a single file to the browser `index.html`, which serves as a single entry point for the app via loading `app/run.coffee`

The `run.coffee` file sets up the environment for `curl` and run the wire.js spec `app/spec`

run.coffee and curl
-------------------

Curl is an AMD loader similar to require.js. The various packages installed via bower are made available here easily via named packages. So for instance to user knockout you can now do this in a module:

    define(['knockout'], function (ko) {
        // Do something
    });

The purpose of this file is to set up that environment and run the base spec of our application. It saves the resulting context to `window.context` for debugging and also logs any errors when wiring that spec.

spec.coffee and wire.js
-----------------------

wire.js is used to provide the underlying architecture for the app. You can read their own [references documents](https://github.com/cujojs/wire/blob/master/docs/README.md)

wire.js works by allowing you to specify objects to create and configure within a context, and define how those objects interact with each other.
