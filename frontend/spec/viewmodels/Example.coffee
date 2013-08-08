`define([
    'app/viewmodels/Example',
    'jquery'
],
function(ExampleVM, jQuery){`

describe "Example", ->

    instance = null
    beforeEach ->
        instance = new ExampleVM()

    it 'has header set to Hello eveyone initially', ->
        expect(instance.header()).toBe 'Hello everyone'

`})`
