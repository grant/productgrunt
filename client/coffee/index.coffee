$ = require 'jquery'

$ ->
  $('.post .downvote').click ->
    productId = $(this).data('productid')
    $.post '/downvote/', productId: productId