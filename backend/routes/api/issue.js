var express = require('express');
var router = express.Router();
const issueController = require('../../controllers/issue');

router.get('/', issueController.getAll);
router.post('/', issueController.add);
router.get('/:issue_id', issueController.getOne);
router.put('/:issue_id', issueController.update);

module.exports = router;
