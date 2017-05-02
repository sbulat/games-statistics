# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(document).on 'input', '.player-row .player-field:last', ->
    block = false
    if $(@).val().length && !block
      $.get '/games/player_row', (res) ->
        block = true
        $(res).insertAfter('.player-row:last')
