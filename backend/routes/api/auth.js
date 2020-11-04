var express = require('express');
var router = express.Router();

const { createToken, verifyToken } = require('../../middlewares/token');

router.get(
  '/github/web',
  (req, res, next) => {
    res.cookie('media_type', 'web', { signed: true, httpOnly: true });
    next();
  },
  verifyToken('github')
);
router.get(
  '/github/ios',
  (req, res, next) => {
    res.cookie('media_type', 'ios', { signed: true, httpOnly: true });
    next();
  },
  verifyToken('github')
);

router.get(
  '/github/callback',
  verifyToken('github', {
    failureRedirect: '/failed',
  }),
  createToken,
  (req, res) => {
    res.cookie('accessToken', res.locals.accessToken, { signed: true, httpOnly: true });
    res.cookie('refreshToken', res.locals.refreshToken, { signed: true, httpOnly: true });
    let redirectUrl = null;
    switch (req.signedCookies.media_type) {
      case 'web':
        redirectUrl = '/';
        break;
      case 'ios':
        redirectUrl = `IssueTracker://login#accessToken=${res.locals.accessToken}refreshToken=${res.locals.refreshToken}`;
        break;
    }
    return res.redirect(redirectUrl);
  }
);

router.get('/token', (req, res) => {
  res.status(200).json(req.signedCookies);
});

module.exports = router;
