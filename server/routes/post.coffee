# POST Routes
User = require '../models/user'
Product = require '../models/product'

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

      newProduct.save (err, product) ->
        res.redirect '/'
    else
      res.send 403
  downvote: (req, res) ->
    productId = req.params.id
    if req.user
      console.log productId
      # Toggle the downvote
      # See if the product is downvoted by this user
      
    else
      res.send 403

module.exports = postRoutes