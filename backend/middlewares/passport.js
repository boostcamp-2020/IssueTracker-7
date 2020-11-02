const { fieldOption, JWTOption, githubOption } = require('../config/passport');
const passportJWT = require('passport-jwt');
const LocalStrategy = require('passport-local').Strategy;
const GithubStrategy = require('passport-github').Strategy;
const JWTStrategy = passportJWT.Strategy;
const { pbkdf2 } = require('../utils/encrypt');
const { User } = require('../models');

const githubVerify = (req, accessToken, refreshToken, profile, done) => {
  User.findOrCreate({
    where: {
      user_id: profile.username,
      type: 'github',
    },
  })
    .then((user) => {
      if (!user) return done(err, null);
      return done(null, user[0]);
    })
    .catch((err) => {
      console.log(err);
    });
};
const localVerify = (req, user_id, password, done) => {
  return User.findOne({
    where: {
      user_id: user_id,
      password: pbkdf2(password, 'salt'),
    },
  })
    .then((user) => done(null, user))
    .catch((err) => done(err));
};
const JWTVerify = (jwtPayload, done) => {
  return User.findOne({
    where: {
      id: jwtPayload.id,
    },
  })
    .then((user) => {
      return done(null, user);
    })
    .catch((err) => {
      return done(err);
    });
};

module.exports = (passport) => {
  passport.use(new LocalStrategy(fieldOption, localVerify));
  passport.use(new JWTStrategy(JWTOption, JWTVerify));
  passport.use(new GithubStrategy(githubOption, githubVerify));
};
