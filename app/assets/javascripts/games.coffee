# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(document).on 'input', '.player-row .player-field:last', ->
    if $(@).val().length
      $.get '/games/player_row', (res) =>
        if $(@).closest('.player-row')[0] == $('.player-row:last')[0]
          $(res).insertAfter('.player-row:last')

  $(document).on 'input', '.player-row .score-field', ->
    r = ['Wygrana', 'Przegrana', 'Remis']
    score = []
    container = $(@).closest('#player-rows')
    container.find('.score-field').map (idx, el) ->
      score.push(parseInt($(el).val()) || 0)

    index_max = score.indexOf(Math.max.apply(Math, score))
    container.find('.result-field').each (idx, el) ->
      $(el).val(if index_max == idx then r[0] else r[1])
