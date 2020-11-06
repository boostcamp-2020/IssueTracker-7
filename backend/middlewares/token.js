require('dotenv').config();
const passport = require('passport');
const jwt = require('jsonwebtoken');

exports.createToken = (req, res, next) => {
  res.locals.accessToken = jwt.sign(req.user, process.env.JWT_SECRET);
  res.locals.refreshToken = jwt.sign(req.user, process.env.JWT_SECRET);
  return next();
};

exports.verifyToken = (type, option) => (req, res, next) => {
  passport.authenticate(type ? type : 'local', option, (err, user, info) => {
    if (user) {
      const { id, type, user_id } = user;
      req.user = { id, type, user_id };
      return next();
    }
    switch (info ? info.name : null || err.name) {
      case 'TokenExpiredError':
        return res.status(419).json({
          message: '토큰이 만료되었습니다',
        });
      default:
        return res.status(401).json({
          message: '유효하지 않은 요청 입니다.',
        });
    }
  })(req, res, next);
};
