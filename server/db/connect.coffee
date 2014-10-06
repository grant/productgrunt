# Connection to DB

config = require './config'

# Connects to MongoDB
module.exports.connect = ->
  mongoose = require 'mongoose'
  mongoose.connect config.url

  db = mongoose.connection
  db.on 'error', (err) ->
    console.error 'connection error'
  db.once 'open', ->
    console.info 'connected to db'