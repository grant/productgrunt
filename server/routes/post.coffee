# POST Routes
User = require_abs + '/models/user'

postRoutes =
  projectPost: (req, res) ->
    res.send 'hi'
  downvote: (req, res) ->
    res.send 'good'

module.exports = postRoutes