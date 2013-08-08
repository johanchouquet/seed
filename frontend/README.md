Frontend Structure
==================

The Django backend serves a single file to the browser [index.html](index.html), which acts as a single entry point for the app by loading [app/run.coffee](app/run.coffee)

(app/run.coffee)[app/run.coffee] file sets up the environment for `curl` and run the wire.js spec [app/spec.coffee](app/spec.coffee)

run.coffee and curl
-------------------

Curl is an AMD loader similar to require.js. The various packages installed via bower are made available here easily via named packages. So for instance to user knockout you can now do this in a module:

```javascript
define(['knockout'], function (ko) {
    // Do something
});
```

The purpose of this file is to set up that environment and run the base spec of our application. It saves the resulting context to `window.context` for debugging and also logs any errors when wiring that spec.

spec.coffee and wire.js
-----------------------

wire.js is used to provide the underlying architecture for the app. They have decent [reference documents](https://github.com/cujojs/wire/blob/master/docs/README.md).

In brief wire.js works by allowing you to specify objects to create and configure within a context, and define how those objects interact with each other. This allows you to:

* Create distinct components with defined behaviours, e.g. a backbone collection or HTML node.
* Configure and place those objects, e.g. inject a reference to the collection into another component, or inject that HTML node into the DOM.
* Connect their methods together, like inputs and outputs in a box and wire diagram.

The last part is powerful as the objects do not need to know about each other. Instead an output method is called, and wire connects that to an input method of another component.

Jasmine tests
-------------

These are stored in `spec` and by running `grunt` they are run every time an `app` file or `spec` file changes. You can create and test javascript modules completely independently of the browser this way. You can code data models and view models in isolation effectively.

Jasmine uses BDD concepts. An example file is included in `spec`, but briefly the modules look like the below. You can include `app` modules the same way that you would include them there.

```javascript
define(['app/SomeModule'], function(SomeModule){
    describe('some test', function() {
        it('has some behaviour', function() {
            instance = new SomeModule();
            expect(instance.someProperty).toBe('someValue');
        });
    });
});
```

AMD modules and coffeescript
----------------------------

All modules are actually written in coffeescript, although the AMD wrapper is written in javascript so that you don't have to indent the whole file. The backticks in the below code tell the coffeescript compiler to interpret the enclosed string as javascript.


```coffeescript
`define([
    'SomeModule',
    'AnotherModule'
], function(SomeModule, AnotherModule) {`

class SomeClass
    constructor: ->
        # Do some stuff

return SomeClass

`})`
```

More
----

More is explained in [app](app)
