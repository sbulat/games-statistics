# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $(document).on 'input', '.player-row .player-field:last', ->
    if $(@).val().length
      $.get '/games/player_row', (res) =>
        if $(@).closest('.player-row')[0] == $('.player-row:last')[0]
          $(res).insertAfter('.player-row:last')

  $(document).on 'blur', '.player-row .player-field', ->
    row = $(@).closest('.player-row')
    score = row.find('.score-field').val()
    if !$(@).val().length && row[0] != $('.player-row:last')[0]
      row.remove()

  $(document).on 'input', '.player-row .score-field', ->
    r = ['Wygrana', 'Przegrana', 'Remis']
    score = []
    container = $(@).closest('#player-rows')
    container.find('.score-field').map (idx, el) ->
      score.push(parseInt($(el).val()) || 0)

    indices_max = getAllIndices(score, (Math.max.apply(Math, score)))
    resultFields = container.find('.result-field')
    resultFields.each (idx, el) ->
      $(el).val(if indices_max.includes(idx) then r[0] else r[1])

    if numberOfPlayersAdded() == 2 && indices_max.length == 2
      resultFields.each (idx, el) ->
        $(el).val(r[2])

getAllIndices = (arr, toFind) ->
  res = []

  for el, i in arr
    if el == toFind
      res.push(i)

  res

numberOfPlayersAdded = () ->
  num = 0

  $('#player-rows .player-field').each (idx, el) ->
    if $(el).val()
      num++

  num
