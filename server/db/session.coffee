# Mongo Session
config = require './config'
module.exports = (session) ->
  MongoStore = require('connect-mongo')(session)
  return {
    secret: config.secret
    maxAge: new Date Date.now() + 3600000
    store: new MongoStore url: config.url
  }