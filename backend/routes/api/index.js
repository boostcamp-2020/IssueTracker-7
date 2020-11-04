const express = require('express');
const router = express.Router();
const auth = require('./auth');
const user = require('./user');
const issue = require('./issue');
const label = require('./label')
const { verifyToken } = require('../../middlewares/token');

router.use('/auth', auth);
router.use(verifyToken('jwt'));
router.use('/user', user);
router.use('/issue', issue);
router.use('/label', label);

module.exports = router;
