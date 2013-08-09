`define([
    'lodash',
    'app/utils/CheckWinner'
]
,function(_, CheckWinner){`

class Game

    BOARDS: {}

    constructor: ->
        @checkWinner = new CheckWinner()

    currentPlayer: null

    start: ->
        @nextTurn 'TL'

    registerBoard: (boardName, board) ->
        @BOARDS[boardName] =
            board: board
            result: null

    nextTurn: (cellName) ->
        @changePlayer()
        nextBoard = @BOARDS[cellName]
        if not nextBoard.result
            nextBoard.board.startTurn @currentPlayer

    checkResult: ->
        current = {}
        for boardName, boardObj of @BOARDS
            current[boardName] = boardObj.result
        @checkWinner.getWinner current

    changePlayer: ->
        if @currentPlayer is 'X'
            @currentPlayer = 'O'
        else
            @currentPlayer = 'X'

    turnFinished: (result, board) ->
        selected = result[0]
        result = result[1]
        for boardName, boardObj of @BOARDS
            break if board is boardObj.board
        boardObj.result = result

        [result, winningLine] = @checkResult()

        # If finished
        if result
            console.log winningLine
            for l in winningLine
                console.log @BOARDS[l]
                @BOARDS[l].board.highlight()
            return

        # check next cell isn't complete
        if @BOARDS[selected].result
            @nextTurn boardName
        else
            @nextTurn selected


return Game

`})`
