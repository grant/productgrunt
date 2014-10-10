# POST Routes
async = require 'async'

User = require '../models/user'
Product = require '../models/product'
Downvote = require '../models/downvote'

mongoose = require 'mongoose'
ObjectId = mongoose.Types.ObjectId

postRoutes =
  projectPost: (req, res) ->
    userId = req.user._id
    title = req.body.title
    tagline = req.body.tagline
    link = req.body.link
    if req.user
      newProduct = new Product
        title: title
        tagline: tagline
        link: link
        posterUser: userId
        displayDay: new Date()

      newProduct.save (err, product) ->
        res.redirect '/'
    else
      res.send 403
  downvote: (req, res) ->
    productId = req.body.productId.substring(1, 25)
    productObjectId = ObjectId(productId)
    if req.user
      userObjectId = req.user._id
      # Toggle the downvote
      # See if the product is downvoted by this user
      Downvote.find
        product: productObjectId
        user: userObjectId
      , (err, data) ->
        if data.length == 0
          # Add downvote
          downvote = new Downvote
            product: productObjectId
            user: userObjectId

          async.parallel [
            (cb) ->
              # Increase product downvote by one
              Product.update _id: productObjectId, {$inc: {downvotes: 1}}, (err, data) ->
                cb(err, data)
            (cb) ->
              downvote.save (err, savedDownvote) ->
                cb(err, savedDownvote)
          ], (err, results) ->
            res.send success: !err
        else
          res.send success: false
    else
      res.send success: false

module.exports = postRoutes