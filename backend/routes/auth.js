var express = require('express');
var router = express.Router();
const token = require('../middlewares/token');
const passport = require('passport');

/* GET home page. */
router.get(
  '/github',
  passport.authenticate('github', {
    authType: 'rerequest',
    scope: ['public_profile', 'email'],
  })
);

router.get('/github/callback', token.verifyToken('github'), (req, res) => res.json(req.token));

module.exports = router;
