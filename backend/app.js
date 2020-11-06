var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
require('dotenv').config();
const sequelize = require('./models').sequelize;
const passport = require('passport');
const passportConfig = require('./middlewares/passport');
const apiRouter = require('./routes/api');
const indexRouter = require('./routes/index');

var app = express();
sequelize.sync();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser(process.env.SECRET_CODE));
app.use(express.static(path.join(__dirname, 'public')));

app.use(passport.initialize());
passportConfig(passport);

app.use('/api', apiRouter);
app.use((req, res) => res.sendFile(__dirname + '/public/index.html'));

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
