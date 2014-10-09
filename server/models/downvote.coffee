# A downvote on a product
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

downvoteSchema = new Schema
  # Product
  product:
    type: ObjectId
    ref: 'Product'
    required: true
  # User
  user:
    type: ObjectId
    ref: 'User'
    required: true

module.exports = mongoose.model 'Downvote', downvoteSchema