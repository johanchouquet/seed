`define([
    'jquery'
], function(jQuery) {`

# Remove global $
jQuery.noConflict()

# Set CSRF cookie for jQuery ajax requests
getCookie = (name) ->
    if document.cookie and document.cookie isnt ''
        cookies = document.cookie.split ';'
        for cookie in cookies
            cookie = jQuery.trim cookie
            # Does this cookie string begin with the name we want?
            if cookie.substring(0, name.length + 1) is (name + '=')
                cookieValue = decodeURIComponent cookie.substring(name.length + 1)
                break
    return cookieValue

csrftoken = getCookie 'csrftoken'

jQuery.ajaxSetup
    crossDomain: false
    beforeSend: (xhr, settings) ->
        xhr.setRequestHeader "X-CSRFToken", csrftoken

`})`
