`define([
    'lodash'
]
,function(_){`

class CheckWinner

    checkWinner: (currentMap) ->
        [result, winner] = @_checkWinner currentMap
        result

    getWinner: (currentMap) ->
        @_checkWinner currentMap

    _checkWinner: (currentMap) ->
        winners  = [
            ['TL', 'TM', 'TR']
            ['ML', 'MM', 'MR']
            ['BL', 'BM', 'BR']

            ['TL', 'ML', 'BL']
            ['TM', 'MM', 'BM']
            ['TR', 'MR', 'BR']

            ['TL', 'MM', 'BR']
            ['TT', 'MM', 'BL']
        ]

        for win in winners
            first = null
            thisWins = _.every win, (cellName) ->
                result = currentMap[cellName]
                first ?= result
                result and result is first
            return [first, win] if thisWins
        return [null, null]


return CheckWinner

`})`
