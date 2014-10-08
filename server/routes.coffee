# Routes
User = require './models/user'

routes =
  index: (req, res) ->
    res.render 'index'
  login: (req, res) ->
    if req.isAuthenticated()
      res.redirect '/auth/twitter/callback'
    else
      res.redirect '/auth/twitter'
  logout: (req, res) ->
    req.logout()
    res.redirect '/'
  twitterAuthCallback: (req, res) ->
    # Create Product Grunt user if doesn't exist
    # Add Product Grunt user to req.user
    res.send(req.user)
  welcome: (req, res) ->
    res.render 'welcome'
  about: (req, res) ->
    res.render 'about'
  user: (req, res) ->
    res.render 'user'
  404: (req, res) ->
    res.status(404).send('404')

module.exports = routes