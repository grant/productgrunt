# Server

# Modules
express = require 'express'
jade = require 'jade'
favicon = require 'serve-favicon'
compression = require 'compression'
methodOverride = require 'method-override'

# Config vars
client_build = 'client_build'
server = 'server'

# Setup
app = express()
app.set 'port', process.env.PORT || 3000

# Jade
app.set 'views', '/views'
app.set 'view engine', 'jade'

# Middleware
app.use favicon client_build + '/images/favicon.ico'
app.use compression()
app.use methodOverride()
app.use express.static client_build

app.listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')

# Routes
routes = require server + '/routes'
app.get '/', routes.index
app.get '/about', routes.about
app.get '/:username', routes.username

# 404
app.use routes[404]