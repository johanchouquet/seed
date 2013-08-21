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
        # Create tasks to create boards. Iterates over BOARD_NAMES and
        # creates a partial for each. e.g. _generateBoard('TL')
        tasks = (@_generateBoard.bind(this, boardName) for boardName in @BOARD_NAMES)
        sequence(tasks).then @_boardsCreated

    _generateBoard: (boardName) =>
        @makeBoard(@_layout).then (board) =>
            @_boardCreated boardName, board.api
            return board

    makeBoard: (element) ->
        @_makeBoard root: element

return BoardFactory

`})`
