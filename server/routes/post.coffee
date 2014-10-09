# POST Routes
User = require_abs + '/models/user'

postRoutes =
  projectPost: (req, res) ->
    if req.user
      res.send 403
    else
      res.send 'hi'
  downvote: (req, res) ->
    if req.user
      # Toggle the downvote
      res.send 'good'
    else
      res.send 403

module.exports = postRoutes