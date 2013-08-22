`define([
    'knockout'
], function(ko) {`

# Simple cell viewmodel, tracks name and state
class Cell
    constructor: (name) ->
        @name = name
        @value = ko.observable()
        @cssClass = ko.computed =>
            "#{@name} #{if @value() then "selected" else ""}"

return Cell

`})`
