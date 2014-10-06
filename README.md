# Product Grunt

Product Grunt is a curation of the worst new products, every day.

## Setup

1. Install Product Grunt locally

- Create a Heroku app (for MongoLab)
- Run the following

```sh
git clone git@github.com:grant/productgrunt.git
cd productgrunt
npm install
git remote add heroku <HEROKU-GIT-URL>
heroku addons:add mongolab
```

2. Create Twitter app

- Go to [https://apps.twitter.com/](apps.twitter.com)
- Add your settings
- Get the Twitter API Key and Secret and put them in a `.env` file in the project's root directory in the following format:

```
TWITTER_CONSUMER_KEY=<KEY>
TWITTER_CONSUMER_SECRET=<SECRET>
```

3. Run the website locally

```sh
foreman start
```

## Dev setup

```sh
coffeegulp
```

### Built with

- :coffee: Coffeescript
- :cloud: Express
- :lipstick: Stylus
- :gem: Jade
- :tropical_fish: Gulp