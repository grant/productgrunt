# A user on the site
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = new Schema
  # Twitter id
  twitterId:
    type: Number
    required: true
  # Twitter username
  twitterUsername:
    type: String
    required: true
  # Twitter profile picture
  twitterProfilePicture:
    type: String
    required: true
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

module.exports = mongoose.model 'User', userSchema