const passport = require('passport');
const refresh = require('passport-oauth2-refresh');
const passportJWT = require('passport-jwt');
const JWTStrategy = passportJWT.Strategy;
const ExtractJWT = passportJWT.ExtractJwt;
const LocalStrategy = require('passport-local').Strategy;
const GithubStrategy = require('passport-github').Strategy;
const { pbkdf2 } = require('../utils/encrypt');
const { User } = require('../models');
require('dotenv').config();
const fieldOption = {
  usernameField: 'user_id',
  passwordField: 'password',
};
const JWTOption = {
  jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET,
};
const githubOption = {
  clientID: process.env.GITHUB_CLIENT_ID,
  clientSecret: process.env.GITHUB_CLIENT_SECRET,
  callbackURL: process.env.GITHUB_CALLBACK_URL,
  accessType: 'offline',
  prompt: 'consent',
  passReqToCallback: true,
};
const githubVerify = (req, accessToken, refreshToken, profile, done) => {
  User.findOrCreate({
    where: {
      user_id: profile.id,
      type: 'github',
    },
  })
    .then((user) => {
      if (!user) return done(err, user);
      return done(null, user, { accessToken, refreshToken });
    })
    .catch((err) => {
      console.log(err);
    });
};
const localVerify = (user_id, password, done) => {
  return User.findOne({
    where: {
      user_id: user_id,
      password: pbkdf2(password, 'salt'),
    },
    attributes: ['id', 'user_id'],
  })
    .then((user) => done(null, user))
    .catch((err) => done(err));
};
const JWTVerify = (jwtPayload, done) => {
  return User.findOne({
    where: {
      id: jwtPayload.id,
    },
    attributes: ['id', 'user_id'],
  })
    .then((user) => {
      return done(null, user);
    })
    .catch((err) => {
      return done(err);
    });
};
module.exports = () => {
  passport.use(new LocalStrategy(fieldOption, localVerify));
  passport.use(new JWTStrategy(JWTOption, JWTVerify));
  const githubStrategy = new GithubStrategy(githubOption, githubVerify);
  passport.use(githubStrategy);
  refresh.use(githubStrategy);
};
