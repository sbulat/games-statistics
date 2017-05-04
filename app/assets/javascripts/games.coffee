# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(document).on 'input', '.player-row .player-field:last', ->
    if $(@).val().length
      $.get '/games/player_row', (res) =>
        if $(@).closest('.player-row')[0] == $('.player-row:last')[0]
          $(res).insertAfter('.player-row:last')
