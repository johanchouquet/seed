`define([
    'lodash'
]
,function(_){`

class Game

    BOARDS: {}

    currentPlayer: null

    start: ->
        @nextTurn 'TL'

    registerBoard: (boardName, board) ->
        @BOARDS[boardName] = board

    nextTurn: (cellName) ->
        @changePlayer()
        @BOARDS[cellName].startTurn @currentPlayer

    changePlayer: ->
        if @currentPlayer is 'X'
            @currentPlayer = 'O'
        else
            @currentPlayer = 'X'

    turnFinished: (result, board) ->
        selected = result[0]
        result = result[1]
        console.log result
        for boardName, _board of @BOARDS
            break if _board is board

        @nextTurn selected


return Game

`})`
