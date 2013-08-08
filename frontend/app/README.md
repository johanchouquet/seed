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


### Running methods and defining connections

