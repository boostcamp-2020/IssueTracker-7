var express = require('express');
var router = express.Router();
const issueController = require('../../controllers/issue');

router.get('/', issueController.get);

module.exports = router;
