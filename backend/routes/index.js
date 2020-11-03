const express = require('express');
const router = express.Router();
const user = require('./user')

router.use('/user', user)

router.get('/', function (req, res, next) {
  res.render('index', {});
});
module.exports = router;