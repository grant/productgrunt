# A user on the site
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = new Schema
  # Full name from Twitter profile
  name:
    type: String
    required: true
  # Custom bio
  bio:
    type: String
    required: true
  # User id #
  uid:
    type: Number
    required: true

exports.User = mongoose.model 'User', userSchema