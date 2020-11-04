var express = require('express');
var router = express.Router();
const issueController = require('../../controllers/issue');

router.get('/', issueController.get);
router.put('/:issue_id', issueController.update);

module.exports = router;
