$ = require 'jquery'

$ ->
  $('.post .downvote').click ->
    productId = $(this).data('productid')
    $.post '/downvote/', productId: productId
    if !$(this).hasClass 'voted'
      $(this).addClass 'voted'
      $voteCount = $(this).find('.vote-count')
      $voteCount.text('-' + (+$voteCount.text().substr(1) + 1))