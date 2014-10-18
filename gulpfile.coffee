# Modules
browserify = require 'gulp-browserify'
clean = require 'gulp-clean'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
imagemin = require 'gulp-imagemin'
gulp = require 'gulp'
gutil = require 'gulp-util'
plumber = require 'gulp-plumber'
pngcrush = require 'imagemin-pngcrush'
prefix = require 'gulp-autoprefixer'
stylus = require 'gulp-stylus'
uglify = require 'gulp-uglify'
watch = require 'gulp-watch'
minify = require 'gulp-minify-css'

# File path config
src =
  coffee: [
    'gulpfile.coffee'
    'client/coffee/**/*.coffee'
    'server/**/*.coffee'
  ]
  coffee_index: 'client/coffee/index.coffee'
  stylus: 'client/stylus/**/*.styl'
  stylus_index: 'client/stylus/pages/*.styl'
  images: 'client/images/*'

dest =
  css: 'client_build/css/pages/'
  coffee: 'client_build/js/'
  images: 'client_build/images/'

# Tasks
gulp.task 'coffee', ->
  # Lint
  console.log '\nLinting coffeescript...\n'
  gulp.src src.coffee
    .pipe coffeelint()
    .pipe coffeelint.reporter()

  # Browserify
  gulp.src src.coffee_index
    # .pipe plumber()
    .pipe coffee().on 'error', gutil.log
    .pipe browserify()
    .pipe uglify()
    .pipe gulp.dest dest.coffee

gulp.task 'stylus', ->
  gulp.src src.stylus_index
    .pipe stylus()
    .pipe prefix()
    .pipe minify()
    .pipe gulp.dest dest.css

gulp.task 'images', ->
  gulp.src src.images
    .pipe imagemin
      progressive: true
      svgoPlugins: [removeViewBox: false]
      use: [pngcrush()]
    .pipe gulp.dest dest.images

gulp.task 'clean', ->
  filesToClean = [
    dest.css + '*.css'
    dest.coffee + '*.js'
    dest.images + '*'
  ]
  gulp.src filesToClean, read: false
    .pipe clean()

gulp.task 'watch', ->
  # Build
  gulp.watch src.coffee, ['coffee']
  gulp.watch src.stylus, ['stylus']
  gulp.watch src.images, ['images']

gulp.task 'default', ['stylus', 'coffee', 'images', 'watch']