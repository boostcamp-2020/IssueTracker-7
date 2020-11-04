const express = require('express');
const router = express.Router();
const milestoneController = require('../../controllers/milestone')

router.get('/', milestoneController.get);

module.exports = router;