const passportJWT = require('passport-jwt');
const ExtractJWT = passportJWT.ExtractJwt;
require('dotenv').config();

const fieldOption = {
  usernameField: 'user_id',
  passwordField: 'password',
  session: false,
  passReqToCallback: true,
};
const JWTOption = {
  jwtFromRequest: ExtractJWT.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET,
};
const githubOption = {
  clientID: process.env.GITHUB_CLIENT_ID,
  clientSecret: process.env.GITHUB_CLIENT_SECRET,
  callbackURL: process.env.GITHUB_CALLBACK_URL,
};

module.exports = { fieldOption, JWTOption, githubOption };
