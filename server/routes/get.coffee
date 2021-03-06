# GET Routes
User = require '../models/user'
Product = require '../models/product'
Downvotes = require '../models/downvote'

getRoutes =
  index: (req, res) ->
    # Get the products that are supposed to display today
    now = new Date()
    startOfDay = new Date(now.getFullYear(), now.getMonth(), now.getDate())

    # downvotedProducts = []
    # if req.user
    #   Downvotes.find user: req.user._id, (err, downvotes) ->
    #     for downvote in downvotes
    #       downvotedProducts.push downvote.product

    # Do the product query
    Product.find()
      .populate('posterUser')
      .sort(downvotes: -1)
      .exec (err, products) ->
        res.render 'index',
          user: req.user
          days: [
            day: startOfDay
            products: products
          ]
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
    req.user = req.user || {}
    twitterId = +req.user.id
    User.findOne twitterId: twitterId, (err, data) ->
      if !data
        # Get new uid
        User.find().sort(uid:-1).limit(1).exec (err, data) ->
          if data.length
            newUid = data[0].uid + 1
          else
            # First user!
            newUid = 1

          # Add user data from twitter API response
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
            if newUserSave
              req.user._id = newUserSave._id
            res.send '<header><meta http-equiv="refresh" content="0; url=/" /></header>'
      else
        # User has data, add it from DB response
        req.user.twitterId = data.twitterId
        req.user.twitterUsername = data.twitterUsername
        req.user.twitterProfilePicture = data.twitterProfilePicture
        req.user.name = data.name
        req.user.bio = data.bio
        req.user.uid = data.uid
        req.user._id = data._id

        res.send '<header><meta http-equiv="refresh" content="0; url=/" /></header>'
  about: (req, res) ->
    res.render 'about',
      user: req.user
  post: (req, res) ->
    res.render 'post',
      user: req.user
  user: (req, res) ->
    # Get the user data
    User.findOne twitterUsername: req.params.username, (err, data) ->
      if !data
        res.send 'User not found'
      else
        res.render 'user',
          user: req.user,
          profile: data
  404: (req, res) ->
    res.status(404).send('404')

module.exports = getRoutes