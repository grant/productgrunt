# Routes
User = require './models/user'

routes =
  index: (req, res) ->
    res.render 'index',
      user: req.user
  login: (req, res) ->
    if req.isAuthenticated()
      res.redirect '/'
    else
      res.redirect '/auth/twitter'
  logout: (req, res) ->
    req.logout()
    res.redirect '/'
  twitterAuthCallback: (req, res) ->
    # Create Product Grunt user if doesn't exist
    twitterId = +req.user.id
    User.findOne twitterId: twitterId, (err, data) ->
      if !data
        # Get new uid
        User.find().sort(uid:-1).limit(1).exec (err, data) ->
          newUid = data[0].uid + 1

          # Add user data
          req.user.twitterId = req.user.id
          req.user.twitterUsername = req.user.username
          photoURL = req.user.photos[0].value
          req.user.twitterProfilePicture = photoURL.split('_normal').join('')
          req.user.name = req.user.displayName
          req.user.bio = req.user._json.description
          req.user.uid = newUid

          newUser = new User
            twitterId: req.user.twitterId
            twitterUsername: req.user.twitterUsername
            twitterProfilePicture: req.user.twitterProfilePicture
            name: req.user.name
            bio: req.user.bio
            uid: req.user.uid

          newUser.save (err, newUserSave) ->
            res.send '<header><meta http-equiv="refresh" content="0; url=/" /></header>'
      else
        # User has data, add it
        req.user.twitterId = data.twitterId
        req.user.twitterUsername = data.twitterUsername
        req.user.twitterProfilePicture = data.twitterProfilePicture
        req.user.name = data.name
        req.user.bio = data.bio

        res.send '<header><meta http-equiv="refresh" content="0; url=/" /></header>'
  about: (req, res) ->
    res.render 'about',
      user: req.user
  user: (req, res) ->
    res.render 'user',
      user: req.user
  404: (req, res) ->
    res.status(404).send('404')

module.exports = routes