`define([
    'knockout'
], function(ko) {`

class ExampleVM
    constructor: (@element) ->
        @properties()

    init: ->
        ko.applyBindings this, @element

    properties: ->
        @header = ko.observable "Hello everyone"

return ExampleVM

`})`
