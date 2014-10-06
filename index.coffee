# Server

# Config vars
TWITTER_CONSUMER_KEY = process.env.TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET = process.env.TWITTER_CONSUMER_SECRET
client_build = './client_build'
server = './server'

# Modules
express = require 'express'
session = require 'express-session'
jade = require 'jade'
favicon = require 'serve-favicon'
compression = require 'compression'
methodOverride = require 'method-override'
passport = require 'passport'
TwitterStrategy = require('passport-twitter').Strategy

db = require server + '/db/connect'
mongoSession = require(server + '/db/session')(session)

# Setup
app = express()
app.set 'port', process.env.PORT || 3000

# Jade
app.set 'views', './views'
app.set 'view engine', 'jade'

# Middleware

# Twitter Strategy
passport.serializeUser (user, done) ->
  done null, user

passport.deserializeUser (obj, done) ->
  done null, obj

passport.use new TwitterStrategy
    consumerKey: TWITTER_CONSUMER_KEY
    consumerSecret: TWITTER_CONSUMER_SECRET
    callbackURL: 'http://0.0.0.0:5000/auth/twitter/callback'
  , (token, tokenSecret, profile, done) ->
    process.nextTick () ->
      return done(null, profile)

# app.use favicon client_build + '/images/favicon.ico'
app.use compression()
app.use methodOverride()
app.use express.static client_build
app.use session mongoSession
app.use passport.initialize()
app.use passport.session()

# DB
db.connect()

# Routes
routes = require server + '/routes'
app.get '/', routes.index
app.get '/about', routes.about
app.get '/login', routes.login
app.get '/logout', routes.logout
app.get '/:username', routes.user
app.get '/auth/twitter', passport.authenticate('twitter')
app.get '/auth/twitter/callback',
  passport.authenticate('twitter', failureRedirect: '/login'),
  (req, res) ->
    res.send(req.user)

# 404
app.use routes[404]

app.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')