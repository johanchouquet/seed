`define([
    'jquery',
    'lodash',
    'when/sequence'
],
function(jQuery, _, sequence){`

class BoardFactory

    # Injected
    _layout: null

    # Output
    _boardCreated: ->
    _boardsCreated: ->

    BOARD_NAMES:  [
        'TL', 'TM', 'TR'
        'ML', 'MM', 'MR'
        'BL', 'BM', 'BR'
    ]

    setupBoards: ->
        success = (board) ->
            window.board = board
        fail = (error) ->
            console.log error
            console.log error.stack

        boardNames = _.clone @BOARD_NAMES
        tasks = (@_generateBoard for name in boardNames)
        sequence(tasks, boardNames). then => @_boardsCreated()

    _generateBoard: (boardNames) =>
        boardName = boardNames.pop()
        elementName = ".board-#{boardName}"
        element = jQuery(@_layout).find(elementName)[0]
        @makeBoard(element).then (board) =>
            @_boardCreated boardName, board.api
            return board

    makeBoard: (element) ->
        @_boardLocation = element
        @_makeBoard()

return BoardFactory

`})`
