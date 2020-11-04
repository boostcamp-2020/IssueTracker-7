const express = require('express');
const router = express.Router();
const labelController = require('../../controller/label');

router.get('/', labelController.get);

module.exports = router;