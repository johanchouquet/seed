Concepts Used
=============

As mentioned [wire.js](https://github.com/cujojs/wire) is used to provide the underlying architecture and environment to work in. We also use [backbone.js](http://backbonejs.org/) to handle our data layer and [knockout](http://knockoutjs.com/) to handle our view layer.

wire.js
-------

The best way to undestand wire is to play around with a spec yourself, and see the resulting context. As mentioned before you can access the context created in the browser by looking at `window.context`.

Spec files are a specification fed into wire, so that all you need to do it define what needs to be created and how they interact. Wire then takes care of resolving the depencies, creating the actual modules, injecting dependencies and creating connections.

### Defining spec

At it's most basic level you can just create a bunch of strings, e.g.

    define
        hello: 'internet'

If you look at context object:

    > console.log(context)
    {hello: "internet"}

### Creating objects

That is quite useless but now you can tell it to create javascript objects and inject dependencies:

    define
        hello: 'internet'
        myObject:
            create:
                module: ['app/MyObject'}
                args: [
                    'someConfig'
                ,
                    $ref: 'string'
                ]

The context now looks like this:

    > console.log(context)
    {hello: "internet', myObject: <MyObject instance>}

You can also pass in arguments to the constructor in the `args` part.

You will also notice the strange looking `$ref` part. This is the syntax used to reference other components. In this case it will pass our string `hello` into the constructor. It is effectively doing this:

    context = {}
    curl ['app/MyObject'], (MyObject) ->
        context.hello = 'internet'
        context.myObject = new MyObject('someConfig', context.hello)

### Properties, methods and defining connections

Getting more complex you can inject properties, run methods at various stages and connect components together.

These are done at various points through each object's lifecycle, which you hook into.

* Create - runs object constructir
* Configure - applies `properties` facet
* Initialize - runs any `init` methods
* Connect - creates any component connections
* Ready - runs any `ready` methods
* Destroy - runs any `destroy` methods

In actual code

    define
        hello: 'internet'
        myObject:
            create:
                module: ['app/MyObject'}
                args: [
                    'someConfig'
                ,
                    $ref: 'string'
                ]
            init:
                initMethod: null


        gehansObject:
            create:
                module: ['app/GehansObject'}
            properties:
                helloProp: $ref: 'hello'
            connect:
                thisMethod: 'myObject.thatMethod'
            ready:
                runMe: ['hello']


So in this example `myObject` is created as before, but in the initialize stage then `initMethod` is called with no arguments.

`gehansObject` is created, and duriing configure is has `gehansObject.helloProp` set to the `hello` component. The connect stage means that when `gehansObject.thisMethod` is called, then `myObject.thatMethod` is called with the same arguments. During ready then `runMe` is called with the argument `'hello'`.
