'use strict';

var path = require('path')
  , fs = require('fs')
  ;

var gulp = require('gulp')
  , env = require('gulp-env')
  , copy = require('gulp-copy')
  , clean = require('gulp-clean')
  , webpack = require('webpack-stream')
  , named = require('vinyl-named')
  , sequence = require('run-sequence')
  ;

var appName = 'tirol';
var assetsDir = path.resolve(__dirname, appName + '/assets/');

// -- [shared tasks]

// loads environment vars from .env
gulp.task('env', function(done) {
  var dotenv_file = '.env';
  if (fs.existsSync(dotenv_file)) {
    return gulp.src(dotenv_file)
    .pipe(env({file: dotenv_file, type: '.ini'}));
  } else {
    return done();
  };
})

// -- [build tasks]

var build = function(files) {
  // eslint-disable-next-line global-require
  var webpackConfig = require('./webpack.config.js');
  return gulp.src(files.map(function(file) {
    return path.resolve(assetsDir, file)
  }))
  .pipe(named())
  .pipe(webpack(webpackConfig))
  .pipe(gulp.dest(path.resolve(__dirname, 'tmp/builds/')));
}

gulp.task('build:vendor', ['env'], function(done) {
  return build(['vendor.js']);
});

gulp.task('build:master', ['env'], function(done) {
  return build(['master.js']);
});

gulp.task('copy:img', ['env'], function(done) {
  return gulp.src(path.resolve(assetsDir, 'img/*'))
  .pipe(named())
  .pipe(copy('static/', {prefix: 2}));
})

gulp.task('copy:favicon', ['env'], function(done) {
  return gulp.src(path.resolve(assetsDir, 'favicon.ico'))
  .pipe(named())
  .pipe(copy('static/', {prefix: 3}));
})

gulp.task('copy:txt', ['env'], function(done) {
  return gulp.src(path.resolve(assetsDir, '{robots,humans}.txt'))
  .pipe(named())
  .pipe(copy('static/', {prefix: 3}));
})

// builds __each__ {vendor|master}.js into %(appName)/tmp/builds
// this run webpack each times.
gulp.task('build', [
  'build:master'
, 'build:vendor'
]);

// builds all scripts at once with license plugin for production mode
// this run webpack only once.
gulp.task('build:all', ['env'], function(done) {
  return build([
    'master.js'
  , 'vendor.js'
  ]);
});


// -- [make tasks]

// places assets files from tmp/builds into static/
gulp.task('distribute', function(done) {
  return gulp.src([
    'tmp/builds/*.js'
  , 'tmp/builds/*.css'
  , 'tmp/builds/*.txt'
  , 'tmp/builds/**/*.svg'
  , 'tmp/builds/manifest.json'
  ])
  .pipe(named())
  .pipe(copy('static/', {prefix: 2}));
})

// applies changes of application files to static/app.js
gulp.task('build-install:master', function(done) {
  return sequence('build:master', 'distribute', done);
});


// -- [development tasks]

// watch targets
var paths = {
  master:  [
    path.join(assetsDir, 'master.js')
  , path.join(assetsDir, 'css/*.styl')
  , path.join(assetsDir, 'js/*.js')
  ]
, img: [
    path.join(assetsDir, 'img/*')
  ]
};

gulp.task('clean', function(done) {
  return gulp.src([
    'tmp/builds/*'
  , 'static/*.js'
  , 'static/*.json'
  , 'static/*.css'
  , 'static/*.txt'
  , 'static/**/*.{eot,svg,ttf,woff,woff2}'
  , 'static/*.ico'
  , 'static/**/*.png'
  ], {
    read: false
  })
  .pipe(clean());
});

// copies other static files from assets into %(appName)/tmp/builds
gulp.task('copy', [
  'copy:img'
, 'copy:favicon'
, 'copy:txt'
]);

// distribute and copy
gulp.task('install', [
  'distribute'
, 'copy'
]);

// watches
gulp.task('watch', ['env'], function(done) {
  gulp.watch('gulpfile.js', ['default']);
  gulp.watch(paths.master, ['build-install:master']);
  gulp.watch(paths.img, ['copy']);
});


// -- [main tasks]

gulp.task('default', ['env'], function(done) {
  var nodeEnv = process.env.NODE_ENV || 'production';
  console.log('» gulp:', nodeEnv);

  var build = (nodeEnv === 'production') ? 'build:all' : 'build';
  return sequence('clean', build, 'install', done);
});