# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#final').change ->
    if $('#inicio').val() > $('#final').val()
      alert "Fecha final no puede ser anterior a la fecha inicial"
      $('#inicio').val(undefined)
      $('#final').val(undefined)
      $('#inicio').focus()
