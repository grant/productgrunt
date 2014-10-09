# Server

# Config vars
TWITTER_CONSUMER_KEY = process.env.TWITTER_CONSUMER_KEY
TWITTER_CONSUMER_SECRET = process.env.TWITTER_CONSUMER_SECRET
client_build = './client_build'
server = './server'
global.require_abs = (file) ->
  require path.join __dirname, file

# Modules
os = require 'os'
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

if os.hostname().indexOf("local") > -1
  callbackURL = 'http://0.0.0.0:5000/auth/twitter/callback'
else
  callbackURL = 'http://productgrunt.com/auth/twitter/callback'
passport.use new TwitterStrategy
    consumerKey: TWITTER_CONSUMER_KEY
    consumerSecret: TWITTER_CONSUMER_SECRET
    callbackURL: callbackURL
  , (token, tokenSecret, profile, done) ->
    process.nextTick () ->
      return done(null, profile)

# Other middleware
app.use favicon client_build + '/images/favicon.ico'
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
app.get '/', routes.get.index
app.get '/about', routes.get.about
app.get '/login', routes.get.login
app.get '/logout', routes.get.logout
app.get '/:username', routes.get.user
app.get '/auth/twitter', passport.authenticate('twitter')
app.get '/auth/twitter/callback',
  passport.authenticate('twitter', failureRedirect: '/login'),
  routes.get.twitterAuthCallback

# 404
app.use routes.get[404]

app.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')