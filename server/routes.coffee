# Routes

routes =
  index: (req, res) ->
    res.render 'index'
  about: (req, res) ->
    res.render 'about'
  user: (req, res) ->
    res.render 'user'
  404: (req, res) ->
    res.status(404).send('404')

module.exports = routes