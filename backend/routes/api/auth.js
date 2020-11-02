var express = require('express');
var router = express.Router();

const { createToken, verifyToken } = require('../../middlewares/token');

router.get('/github', verifyToken('github'));

router.get(
  '/github/callback',
  verifyToken('github', {
    failureRedirect: '/failed',
  }),
  createToken,
  (req, res) => {
    res.cookie('accessToken', res.locals.accessToken, { signed: true, httpOnly: true });
    res.cookie('refreshToken', res.locals.refreshToken, { signed: true, httpOnly: true });
    return res.redirect('/');
  }
);

router.get('/token', (req, res) => {
  res.status(200).json(req.signedCookies);
});

module.exports = router;
