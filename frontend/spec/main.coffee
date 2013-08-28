`define([
    'app/main'
],function(main){`

describe "Main", ->

    it "inits correctly", ->
        m = new main()
        expect(m.init()).toBe 'INIT'

`})`
