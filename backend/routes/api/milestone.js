const express = require('express');
const router = express.Router();
const milestoneController = require('../../controllers/milestone');

router.get('/', milestoneController.getAll);

module.exports = router;
