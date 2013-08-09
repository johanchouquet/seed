`define([
    'knockout',
    'app/utils/CheckWinner'
], function(ko, CheckWinner){`

class Cell
    constructor: (name) ->
        @name = name
        @value = ko.observable()

class Board

    CELL_NAMES:  [
        'TL', 'TM', 'TR'
        'ML', 'MM', 'MR'
        'BL', 'BM', 'BR'
    ]

    constructor: (@element) ->
        @winCheck = new CheckWinner()
        @properties()

    properties: ->
        @highlighted = ko.observable false
        @boardEnabled = ko.observable false
        @currentPlayer = ko.observable 'O'
        @cells = ko.observableArray()
        @winner = ko.observable()
        for cellName in @CELL_NAMES
            cell = new Cell cellName
            @cells.push cell

    # INPUT
    startTurn: (player) ->
        @boardEnabled true
        @currentPlayer player

    # OUTPUT
    turnFinished: (cell) ->
        @boardEnabled false
        [cell, @checkWinner()]

    checkWinner: ->
        current = {}
        for cell in @cells()
            current[cell.name] = cell.value()
        winner = @winCheck.checkWinner current
        @winner winner
        winner

    highlight: ->
        console.log "I WINZ"
        @highlighted true

    clicked: (model, event) =>
        return unless @boardEnabled()
        if not model.value()
            model.value @currentPlayer()
            @turnFinished model.name

    init: ->
        ko.applyBindings this, @element


return Board

`})`
