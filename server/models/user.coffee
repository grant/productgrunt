# A user on the site
mongoose = require 'mongoose'

Schema = mongoose.Schema
ObjectId = Schema.ObjectId

userSchema = new Schema
  name:
    type: String
    required: true
  bio:
    type: String
    required: true
  uid:
    type: Number
    required: true

exports.User = mongoose.model 'User', userSchema