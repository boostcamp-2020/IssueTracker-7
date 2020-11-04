const express = require('express');
const router = express.Router();
const userController = require('../../controller/user');

router.get('/', userController.get);

module.exports = router; 