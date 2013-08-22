`define([
    'knockout',
    './Cell',
    'app/utils/CheckWinner'
], function(ko, Cell, CheckWinner){`

class Board

    CELL_NAMES:  [
        'TL', 'TM', 'TR'
        'ML', 'MM', 'MR'
        'BL', 'BM', 'BR'
    ]
    winner: null

    # INPUT
    startTurn: (player) ->
        @boardEnabled true
        @currentPlayer player

    # OUTPUT
    turnFinished: (selectedCell) ->
        @boardEnabled false
        @checkWinner()
        selectedCell

    # OUTPUT
    getWinner: ->
        @winner()

    constructor: (@element) ->
        @winCheck = new CheckWinner()
        @properties()

    init: ->
        ko.applyBindings this, @element

    # Set up the viewmodel. Create a cell viewmodel for each location, which
    # allows keeping track of game state a lot simpler
    properties: ->
        @highlighted = ko.observable false
        @boardEnabled = ko.observable false
        @currentPlayer = ko.observable 'O'
        @cells = ko.observableArray()
        @winner = ko.observable()
        for cellName in @CELL_NAMES
            cell = new Cell cellName
            @cells.push cell

    checkWinner: ->
        current = {}
        for cell in @cells()
            current[cell.name] = cell.value()
        @winner @winCheck.checkWinner current
        @winner()

    highlight: ->
        @highlighted true

    clicked: (model, event) =>
        return unless @boardEnabled()
        if not model.value()
            model.value @currentPlayer()
            @turnFinished model.name

return Board

`})`
