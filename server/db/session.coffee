# Mongo Session
config = require './config'
module.exports = (express) ->
  MongoStore = require('connect-mongo')(express)
  return
    secret: config.secret
    maxAge: new Date Date.now() + 3600000
    store: new MongoStore url: config.url