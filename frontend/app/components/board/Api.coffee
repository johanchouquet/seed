`define(function(){`

class Api

    # Output
    _turnFinished: (selectedCell, boardApi) ->

    # Start turn for player
    startTurn: ->

    # Check if there is a winner
    getWinner: ->
        @_board.getWinner()

    # Turn finished
    turnFinished: (selectedCell) ->
        @_turnFinished selectedCell, this

    # Instrcut board to highlight as this was on
    # winnning line
    highlight: ->


return Api

`})`

