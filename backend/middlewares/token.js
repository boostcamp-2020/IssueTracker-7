const passport = require('passport');

exports.verifyToken = (type) => (req, res, next) => {
  passport.authenticate(type, { session: false }, (err, user, info) => {
    if (user) {
      req.user = user;
      req.token = info;
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
