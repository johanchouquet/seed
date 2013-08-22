`define([
    'lodash',
    'when/sequence'
],
function(_, sequence){`

class BoardFactory

    # Injected
    _layout: null

    # Output
    _boardCreated: ->
    _allBoardsCreated: ->

    BOARD_NAMES:  [
        'TL', 'TM', 'TR'
        'ML', 'MM', 'MR'
        'BL', 'BM', 'BR'
    ]

    # Creates all 9 boards using a single component
    #
    # Iterates over BOARD_NAMES and creates a partial for each.
    # e.g. _generateBoard('TL'). Each task returns a promise.
    #
    # Sequence will run each promise in turn so that they appear in the right
    # order in the UI. After all promises are resolved then it will notify the
    # game manager that all boards are created.
    setupBoards: ->
        tasks = (@_generateBoard.bind(this, boardName) for boardName in @BOARD_NAMES)
        sequence(tasks).then @_allBoardsCreated

    # Creates a single instance of the board and registers it with the gameManager
    #
    # _makeBoard has been injected by the spec and runs the wire spec for the
    # board component. It allows you to mixin another spec, which in this case
    # is just the root variable, which is the dom element to add the board
    # node to.
    _generateBoard: (boardName) =>
        @_makeBoard(root: @_layout).then (board) =>
            @_boardCreated boardName, board.api
            return board

return BoardFactory

`})`
