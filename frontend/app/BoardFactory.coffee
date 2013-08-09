`define(function(){`

class BoardFactory

    init: ->
        console.log 'init'

    makeBoard: (element) ->
        @_boardLocation = element

        success = ->
        fail = (error) ->
            console.log error

        @_makeBoard().then success, fail

return BoardFactory

`})`
