#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require_tree .


$ ->
  $('.answer').click ->
    correct_answer = $('.answer[data-correct=true]').css('background-color', 'RGBA(0, 204, 0, 0.5)')
    if $(this).data('correct') == false
      $(this).css('background-color', 'RGBA(255, 0, 0, 0.5)')
    $(this).find('#answer-icon').removeClass('hide')
    correct_answer.find('#answer-icon').removeClass('hide')
    return