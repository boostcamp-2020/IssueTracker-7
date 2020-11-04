const express = require('express');
const router = express.Router();
const auth = require('./auth');
const { verifyToken } = require('../../middlewares/token');

router.use('/auth', auth);
router.use(verifyToken('jwt'));
router.use('/user', user);
router.use('/issue', issue);

module.exports = router;
