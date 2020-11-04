var express = require('express');
var router = express.Router();
const auth = require('./auth');
const user = require('./user')
const { verifyToken } = require('../../middlewares/token');

router.use('/auth', auth);
router.use(verifyToken('jwt'));
router.use('/user', user)

module.exports = router;