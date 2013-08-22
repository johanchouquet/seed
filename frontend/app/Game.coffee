`define([
    'lodash',
    'app/utils/CheckWinner'
]
,function(_, CheckWinner){`

class Game

    BOARDS: {}
    currentPlayer: null

    constructor: ->
        @checkWinner = new CheckWinner()

    # INPUT
    # Register this board, including its location name. Keep final
    # board score here too.
    registerBoard: (boardName, board) ->
        @BOARDS[boardName] = board

    # INPUT
    # Called when all boards are registered, starts game
    start: ->
        @nextTurn 'TL'

    nextTurn: (cellName) ->
        @changePlayer()
        nextBoard = @BOARDS[cellName]
        if not nextBoard.getWinner()
            nextBoard.startTurn @currentPlayer

    checkResult: ->
        current = {}
        for boardName, boardObj of @BOARDS
            current[boardName] = boardObj.getWinner()
        @checkWinner.getWinner current

    changePlayer: ->
        if @currentPlayer is 'X'
            @currentPlayer = 'O'
        else
            @currentPlayer = 'X'

    turnFinished: (selectedCell, board) ->
        [result, winningLine] = @checkResult()

        # If finished then highlight the winner
        if result
            console.log winningLine
            @BOARDS[l].highlight() for l in winningLine

        # Else activate game in last selected cell if not finished
        else if not @BOARDS[selectedCell].getWinner()
            @nextTurn selectedCell

        # Else go again on same board
        else
            boardName = _.findKey @BOARDS, (boardObj) ->
                board is boardObj
            @nextTurn boardName

return Game

`})`
