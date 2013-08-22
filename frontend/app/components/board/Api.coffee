`define(function(){`

class Api

    # Start turn for player
    startTurn: ->

    # After turn finished. Send the selected cell back to the game manager
    # with a reference to ourself so it knows who we are
    turnFinished: (selectedCell) ->
        @_turnFinished selectedCell, this

    # Return if there is a winner
    getWinner: ->
        @_board.getWinner()

    # Instruct board to highlight as this was on
    # winnning line
    highlight: ->

    # Output
    _turnFinished: (selectedCell, boardApi) ->

return Api

`})`

