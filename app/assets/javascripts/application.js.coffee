#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require_tree .

$ ->
  $('.answer').bind 'click',  ->
    $('.answer').unbind('click')
    correct_answer = $('.answer[data-correct=true]').css('background-color', 'RGBA(0, 204, 0, 0.5)')
    success = true
    if $(this).data('correct') == false
      success = false
      $(this).css('background-color', 'RGBA(255, 0, 0, 0.5)')
    $(this).find('#answer-icon').removeClass('hide')
    correct_answer.find('#answer-icon').removeClass('hide')

    el = $(this)
    $.ajax
      type: "POST"
      url: el.data('send-result-link')
      data:
        success: success
      success: (data) ->
        $('#state').html data
      error: (error) ->
        console.log data

    return