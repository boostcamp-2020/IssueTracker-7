var express = require('express');
var router = express.Router();
const auth = require('./auth');
const { verifyToken } = require('../../middlewares/token');

router.use('/auth', auth);
router.use(verifyToken('jwt'));

module.exports = router;
