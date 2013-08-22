`define([
    'lodash',
    'app/utils/CheckWinner'
]
,function(_, CheckWinner){`

# Controls the flow of the game. The boards are registered with the manager by
# the board factory.
class Game

    BOARDS: {}
    currentPlayer: null

    constructor: ->
        @checkWinner = new CheckWinner()

    # INPUT
    # Register this board as its location
    registerBoard: (boardName, board) ->
        @BOARDS[boardName] = board

    # INPUT
    # Called when all boards are registered, starts game
    start: ->
        @nextTurn 'TL'

    # INPUT
    # When a board has finished its turn then this is called. Check for
    # a winnin line otherwise start the next turn.
    turnFinished: (selectedCell, board) ->
        [winner, winningLine] = @checkForWinner()

        # If finished then highlight the winner
        if winner
            @BOARDS[l].highlight() for l in winningLine

        # Else activate game in last selected cell if possible
        else if not @BOARDS[selectedCell].getWinner()
            @nextTurn selectedCell

        # Else go again on same board
        else
            boardName = _.findKey @BOARDS, board
            @nextTurn boardName

    # Change player and instruct the next board to start
    # its turn
    nextTurn: (cellName) ->
        nextPlayer = @changePlayer()
        nextBoard = @BOARDS[cellName]
        nextBoard.startTurn nextPlayer

    changePlayer: ->
        if @currentPlayer is 'X'
            @currentPlayer = 'O'
        else
            @currentPlayer = 'X'

    checkForWinner: ->
        current = {}
        for boardName, boardObj of @BOARDS
            current[boardName] = boardObj.getWinner()
        @checkWinner.getWinner current

return Game

`})`
