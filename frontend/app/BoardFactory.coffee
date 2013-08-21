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
        # We perform these tasks in sequence so they appear in the right order
        # in the UI and then notify the game manager that all boards are created
        sequence(tasks).then @_boardsCreated

    _generateBoard: (boardName) =>
        # _makeBoard calls the wire spec for the board component
        # and injects the root element. On finish we notify the Game
        # manager that the baord has been cretaed
        @_makeBoard(root: @_layout).then (board) =>
            @_boardCreated boardName, board.api
            return board

return BoardFactory

`})`
