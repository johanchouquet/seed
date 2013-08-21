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
        # Create tasks to create boards. Iterates over BOARD_NAMES and
        # creates a partial for each. e.g. _generateBoard('TL')
        tasks = (@_generateBoard.bind(this, boardName) for boardName in @BOARD_NAMES)
        parallel(tasks).then @_boardsCreated

    _generateBoard: (boardName) =>
        elementName = ".board-#{boardName}"
        element = jQuery(@_layout).find(elementName)[0]
        @makeBoard(element).then (board) =>
            @_boardCreated boardName, board.api
            return board

    makeBoard: (element) ->
        @_makeBoard root: element

return BoardFactory

`})`
