Concepts Used
=============

As mentioned [wire.js](https://github.com/cujojs/wire) is used to provide the underlying architecture and environment to work in. We also use [backbone.js](http://backbonejs.org/) to handle our data layer and [knockout](http://knockoutjs.com/) to handle our view layer.

wire.js
-------

The best way to undestand wire is to play around with a spec yourself, and see the resulting context. As mentioned before you can access the context created in the browser by looking at `window.context`.

Spec files are a specification fed into wire, so that all you need to do it define what needs to be created and how they interact. Wire then takes care of resolving the depencies, creating the actual modules, injecting dependencies and creating connections.

### Defining spec

At it's most basic level you can just create a bunch of strings, e.g.

```coffeescript
define
    hello: 'internet'
```

If you look at context object:

```javascript
> console.log(context)
{hello: "internet"}
```

### Creating components

That is quite useless but now you can tell it to create javascript objects and inject dependencies:

```coffeescript
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
```

The context now looks like this:

```javascript
> console.log(context)
{hello: "internet", myObject: <MyObject instance>}
```

You can also pass in arguments to the constructor in the `args` part.

You will also notice the strange looking `$ref` part. This is the syntax used to reference other components. In this case it will pass our string `hello` into the constructor. It is effectively doing this:

```coffeescript
context = {}
curl ['app/MyObject'], (MyObject) ->
    context.hello = 'internet'
    context.myObject = new MyObject('someConfig', context.hello)
```

[More on components](https://github.com/cujojs/wire/blob/master/docs/components.md)

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

```coffeescript
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
```

So in this example `myObject` is created as before, but in the initialize stage then `initMethod` is called with no arguments.

`gehansObject` is created, and during configure is has `gehansObject.helloProp` set to the `hello` component. The connect stage means that when `gehansObject.thisMethod` is called, then `myObject.thatMethod` is called with the same arguments. During ready then `runMe` is called with the argument `'hello'`.

[More connection options](https://github.com/cujojs/wire/blob/master/docs/connections.md)

backbone.js
-----------

Backbone is good for providing data models and a way to retrieve/persist them from the server. A server is not necessary as we can point to a JSON file for retrieving a data set initially, and then just retain the collection in memory.


knockout.js
-----------

Knockout is used to create a 2-way binding between a javascript object (view model) and an html template (view). This is similar to django views, where you would pass a context into a template. However whereas in Django you render the template once and send to the browser, with knockout you are creating a live 2-way binding with the dom. The view is created in dom, and then 2-way binding is created to the knockout view model.

This in incredible powerful as it means whenever the view model is changed, so is the dom. For instance if you have an array of items int he view model and a for loop to display them in the DOM, then if you programatically add something to that array then it will just appear the dom. Likewise if the dom changes, then so does the view model. If you enter some text into an input, then the view model can be updated with that value.

A very small example. Given this view model

```coffeescript
class ViewModel
    constructor: ->
        @title = ko.observable 'Hello'
        @items = ko.observableArray [
            'text': 'Hello'
        ,
            'text': 'Yes mate'
        ]
    addSomething: =>
        @items.push
            'text': 'super awesome'
```

and this templte

```html
<div>
    <h1 data-bind="text: title"></h1>
    <ul data-bind="foreach: items">
        <li data-bind="text: text"></li>
    </ul>
    <button data-bind="click: addSomething">Add Something</button>
</div>
```

You will get this in the dom

```html
<div>
    <h1>Hello</h1>
    <ul>
        <li>Hello</li>
        <li>Yes mate</li>
    </ul>
    <button>Add Something</button>
</div>
```

And when you click the `Add Something`, the items array gets extended and now the dom looks like this

```html
<div>
    <h1>Hello</h1>
    <ul>
        <li>Hello</li>
        <li>Yes mate</li>
        <li>super awesome</li>
    </ul>
    <button>Add Something</button>
</div>
```
Knockout tutorials are the best way to learn though:

[Knockout example](http://learn.knockoutjs.com/)
