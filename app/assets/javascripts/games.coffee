# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(document).on 'input', '.player-row .name-field:last', ->
    if $(@).val().length == 1
      $.get '/games/player_row', (res) ->
        $(res).insertAfter('.player-row:last')
