const express = require('express');
const router = express.Router();
const userController = require('../../controllers/user');

router.get('/', userController.getAll);

module.exports = router; 