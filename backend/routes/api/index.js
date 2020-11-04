var express = require('express');
var router = express.Router();
const auth = require('./auth');
const issue = require('./issue');
const { verifyToken } = require('../../middlewares/token');

router.use('/auth', auth);
router.use(verifyToken('jwt'));
router.use('/issue', issue);

module.exports = router;
