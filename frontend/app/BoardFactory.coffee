`define([
    'jquery',
    'lodash',
    'when/parallel'
],
function(jQuery, _, parallel){`

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
        boardNames = _.clone @BOARD_NAMES
        tasks = (@_generateBoard for name in boardNames)
        parallel(tasks, boardNames).then @_boardsCreated

    _generateBoard: (boardNames) =>
        boardName = boardNames.pop()
        elementName = ".board-#{boardName}"
        element = jQuery(@_layout).find(elementName)[0]
        @makeBoard(element).then (board) =>
            @_boardCreated boardName, board.api
            return board

    makeBoard: (element) ->
        @_makeBoard root: element

return BoardFactory

`})`
