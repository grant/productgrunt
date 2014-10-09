# A product
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

productSchema = new Schema
  # Title
  title:
    type: String
    required: true
  # Tagline
  tagline:
    type: String
    required: true
  # Link
  link:
    type: String
    required: true
  # The user id of the poster
  posterUser:
    type: ObjectId
    ref: 'User'
    required: true
  # The date that the product is displayed under, null if not displayed yet
  diplayDay:
    type: Date

module.exports = mongoose.model 'Product', productSchema