`define([
    'knockout'
], function(ko) {`

class ExampleVM
    constructor: (@element) ->

    init: ->
        @properties()
        ko.applyBindings this, @element

    properties: ->
        @header = ko.observable "Hello everyone"

return ExampleVM

`})`
