`define([
    'lodash'
]
,function(_){`

class CheckWinner

    checkWinner: (currentMap) ->
        console.log currentMap
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
            return first if thisWins

return CheckWinner

`})`
